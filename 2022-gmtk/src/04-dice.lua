local cam

-- helper functions
function lerp(a,b,t)
	return a*(1-t)+b*t
end

-- vector helpers
function make_v(a,b)
	return {
		b[1]-a[1],
		b[2]-a[2],
		b[3]-a[3]}
end
function v_clone(v)
	return {v[1],v[2],v[3]}
end
function v_dot(a,b)
	return a[1]*b[1]+a[2]*b[2]+a[3]*b[3]
end
function v_scale(v,scale)
	v[1]*=scale
	v[2]*=scale
	v[3]*=scale
end
function v_add(v,dv,scale)
	scale=scale or 1
	return {
		v[1]+scale*dv[1],
		v[2]+scale*dv[2],
		v[3]+scale*dv[3]}
end
-- safe vector length
function v_len(v)
	local x,y,z=v[1],v[2],v[3]
	local d=max(max(abs(x),abs(y)),abs(z))
	if(d<0.001) return 0
	x/=d
	y/=d
	z/=d
	return d*(x*x+y*y+z*z)^0.5
end
function v_normz(v)
	local x,y,z=v[1],v[2],v[3]
	local d=x*x+y*y+z*z
	if d>0.001 then
		d=d^.5
		return {x/d,y/d,z/d}
	end
	return v
end

function v_lerp(a,b,t)
	return {
		lerp(a[1],b[1],t),
		lerp(a[2],b[2],t),
		lerp(a[3],b[3],t)
	}
end
function v_cross(a,b)
	local ax,ay,az=a[1],a[2],a[3]
	local bx,by,bz=b[1],b[2],b[3]
	return {ay*bz-az*by,az*bx-ax*bz,ax*by-ay*bx}
end

-- inline matrix invert
-- inc. position
function m_inv_x_v(m,v)
	local x,y,z=v[1]-m[13],v[2]-m[14],v[3]-m[15]
	return {m[1]*x+m[2]*y+m[3]*z,m[5]*x+m[6]*y+m[7]*z,m[9]*x+m[10]*y+m[11]*z}
end

-- returns foward vector from matrix
function m_fwd(m)
	return {m[9],m[10],m[11]}
end
-- returns up vector from matrix
function m_up(m)
	return {m[5],m[6],m[7]}
end
function m_x_v(m,v)
	local x,y,z=v[1],v[2],v[3]
	return {m[1]*x+m[5]*y+m[9]*z+m[13],m[2]*x+m[6]*y+m[10]*z+m[14],m[3]*x+m[7]*y+m[11]*z+m[15]}
end

function m_x_m(a,b)
	local a11,a12,a13,a21,a22,a23,a31,a32,a33=a[1],a[5],a[9],a[2],a[6],a[10],a[3],a[7],a[11]
	local b11,b12,b13,b14,b21,b22,b23,b24,b31,b32,b33,b34=b[1],b[5],b[9],b[13],b[2],b[6],b[10],b[14],b[3],b[7],b[11],b[15]

	return {
			a11*b11+a12*b21+a13*b31,a21*b11+a22*b21+a23*b31,a31*b11+a32*b21+a33*b31,0,
			a11*b12+a12*b22+a13*b32,a21*b12+a22*b22+a23*b32,a31*b12+a32*b22+a33*b32,0,
			a11*b13+a12*b23+a13*b33,a21*b13+a22*b23+a23*b33,a31*b13+a32*b23+a33*b33,0,
			a11*b14+a12*b24+a13*b34+a[13],a21*b14+a22*b24+a23*b34+a[14],a31*b14+a32*b24+a33*b34+a[15],1
		}
end

function make_m_from_euler(x,y,z)
	local a,b = cos(x),-sin(x)
	local c,d = cos(y),-sin(y)
	local e,f = cos(z),-sin(z)

	-- yxz order
	local ce,cf,de,df=c*e,c*f,d*e,d*f
 	return {
 		ce+df*b,a*f,cf*b-de,0,
  		de*b-cf,a*e,df+ce*b,0,
  		a*d,-b,a*c,0,
  		0,0,0,1}
end

function prepare_model(model)
	for _,f in pairs(model.f) do
		-- de-reference vertex indices
		for i=1,4 do
			f[i]=model.v[f[i]]
		end

		-- normal
		f.n=v_normz(
				v_cross(
					make_v(f[1],f[4]),
					make_v(f[1],f[2])))
		-- fast viz check
		f.cp=v_dot(f.n,f[1])
	end
	return model
end

function make_cam()
    return {
        x_ang=0, dx_ang=0, dx_frc=1,
        y_ang=0, dy_ang=0, dy_frc=1,
        z_ang=0, dz_ang=0, dz_frc=1,

        pos={0,0,0},
        control=function(a)
            a.x_ang+=a.dx_ang
            a.y_ang+=a.dy_ang
            a.z_ang+=a.dz_ang

            a.dx_ang*=a.dx_frc
            a.dy_ang*=a.dy_frc
            a.dz_ang*=a.dz_frc

            local m=make_m_from_euler(a.z_ang,a.y_ang,a.x_ang)
            local pos=m_fwd(m)
            v_scale(pos,2)

            -- inverse view matrix
            -- only invert orientation part
            m[2],m[5]=m[5],m[2]
            m[3],m[9]=m[9],m[3]
            m[7],m[10]=m[10],m[7]        

            a.m=m_x_m(m,{
                1,0,0,0,
                0,1,0,0,
                0,0,1,0,
                -pos[1],-pos[2],-pos[3],1
            })

            a.pos=pos
        end,
        project=function(a,verts, x0, y0)
            local n,f=0.1,.15
            for i,v in pairs(verts) do
                local x,y,z=v[1],v[2],v[3]
                local w=24/z
                verts[i]={x=x0+x*w,y=y0-y*w,w=w,u=v.u,v=v.v}
            end
            return verts
        end
    }
end

zclass[[dice,actor,drawlayer_50|
    x,@, y,@, xdir,@,

    cam,@, model,@,

    draw,%dice_draw_model,
    roll,%dice_roll,
    sit,%dice_sit,
    update,%dice_update
]]

|[dice_draw_model]| function(a)
    local model=a.model
    local cam=a.cam
	local m={
		1,0,0,0,
		0,1,0,0,
		0,0,1,0,
		-0.5,-0.5,-0.5,1}

	-- cam pos in object space
	local cam_pos=m_inv_x_v(m,cam.pos)
	
	-- object to world
	-- world to cam
	m=m_x_m(cam.m,m)

	for _,face in pairs(model.f) do
		-- is face visible?
		if v_dot(face.n,cam_pos)>face.cp then
			local verts={}
			for k=1,4 do
				-- transform to world
				local p=m_x_v(m,face[k])
				-- attach u/v coords to output
				p.u=face.uv[2*k-1]
				p.v=face.uv[2*k]
				verts[k]=p
			end
			-- transform to camera & draw			
		 verts=cam:project(verts, a.x, a.y)
			polytex(verts)
		end
	end
end $$

|[dice_roll]| function(a, dir)
    if a.is_sit then
        a.is_sit=false
        a.cam.dx_ang = .0625*dir
        a.cam.dy_ang = -.0037*dir
        a.cam.dz_ang = .0332*dir
        a.cam.dx_frc = 1
        a.cam.dy_frc = 1
        a.cam.dz_frc = 1
    end
end $$

|[dice_sit]| function(a)
    if not a.is_sit then
        a.is_sit = true
        a.cam.dx_frc = .8
        a.cam.dy_frc = .8
        a.cam.dz_frc = .8
    end
end $$

|[dice_update]| function(a)
    a.cam:control()
end $$

function create_dice(x, y)
    return _g.dice(x, y, 1, make_cam(63.5,63.5), prepare_model({
            v={
                {0,0,0}, {1,0,0}, {1,0,1}, {0,0,1},
                {0,1,0}, {1,1,0}, {1,1,1}, {0,1,1},
            },
            f={
                {3,4,8,7,uv=zobj[[,122,0,124,0,124,2,122,2]]}, -- 1
                {4,1,5,8,uv=zobj[[,124,0,126,0,126,2,124,2]]}, -- 2
                {1,4,3,2,uv=zobj[[,126,0,128,0,128,2,126,2]]}, -- 3
                {5,6,7,8,uv=zobj[[,122,2,124,2,124,4,122,4]]}, -- 4
                {2,3,7,6,uv=zobj[[,124,2,126,2,126,4,124,4]]}, -- 5
                {1,2,6,5,uv=zobj[[,126,2,128,2,128,4,126,4]]}, -- 6
            }
        })
    )
end

-- textured edge renderer
function polytex(v)
	local p0,nodes=v[#v],{}
	local x0,y0,u0,v0=p0.x,p0.y,p0.u,p0.v
	for i=1,#v do
		local p1=v[i]
		local x1,y1,u1,v1=p1.x,p1.y,p1.u,p1.v
		local _x1,_y1,_u1,_v1=x1,y1,u1,v1
		if(y0>y1) x0,y0,x1,y1,u0,v0,u1,v1=x1,y1,x0,y0,u1,v1,u0,v0
		local dy=y1-y0
		local dx,du,dv=(x1-x0)/dy,(u1-u0)/dy,(v1-v0)/dy
		if(y0<0) x0-=y0*dx u0-=y0*du v0-=y0*dv y0=0
		local cy0=ceil(y0)
		-- sub-pix shift
		local sy=cy0-y0
		x0+=sy*dx
		u0+=sy*du
		v0+=sy*dv

		for y=cy0,min(ceil(y1)-1,127) do
			local x=nodes[y]
			if x then
				-- rectfill(x[1],y,x0,y,7)
				-- backup current edge values
				local a,au,av,b,bu,bv=x[1],x[2],x[3],x0,u0,v0
				if(a>b) a,au,av,b,bu,bv=b,bu,bv,a,au,av
				
				local x0,x1=ceil(a),min(ceil(b)-1,127)
				if x0<=x1 then
					local dab=b-a
					local dau,dav=(bu-au)/dab,(bv-av)/dab
					-- sub-pix shift
					local sa=x0-a
					au+=sa*dau
					av+=sa*dav
					tline(x0,y,x1,y,au,av,dau,dav)
			 end
			else
				nodes[y]={x0,u0,v0}
			end
			x0+=dx
			u0+=du
			v0+=dv
		end
		x0,y0,u0,v0=_x1,_y1,_u1,_v1
	end
end
