function _init()
    -- testing basic nesting "."
    ta("{a=a,b=b}",         ztable[[a:a;b:b;]])
    ta("{a={b=a.b},b=b}",   ztable[[a.b:a.b;b:b;]])
    ta("{a={b={c=a.b.c}}}", ztable[[a.b.c:a.b.c;]])
    ta("{a={b={c=a.b.c}}}", ztable[[a.b:a.b;.c:a.b.c;]])
    ta("{a={b=a.b,c=a.c}}", ztable[[a:;.b:a.b;.c:a.c;]])

    -- testing parameters "@"
    ta("{a=a,b=b}", ztable([[a:@;b:@;]], "a", "b"))
    ta("{a=a,b=b}", ztable([[a:@;b:@;c:@;]], "a", "b"))
    ta("{a={b=.b,c=.c},d={e=.e,f=.f}}", ztable([[a:;.b:.b;.c:@;d:;.e:.e;.f:.f]], ".c"))

    -- testing values "nf/no/yes/null"
    ta("{nf=[function],no=false,yes=true}", ztable[[yes:yes;no:no;null:null;nf:nf;nf:;yes:]])

    -- testing arrays "#"
    ta("{{1,2,3}}",     ztable[[.#:1;.#:2;.#:3;]])
    ta("{{1,2,3}}",     ztable[[.#:1:2:3;]])
    ta("{1,2,3}",       ztable[[#:1;#:2;#:3;]])
    ta("{1,2,3}",       ztable[[#:1:2:3]])
    ta("{1,2,3}",       ztable[[#;:1:2:3]])
    ta("{{1},{2},{3}}", ztable[[#.#:1;#.#:2;#.#:3;]])
    ta("{{1},{2},{3}}", ztable[[#.#:1:2:3;]])
    ta("{uno,dos}",     ztable[[#:uno:dos;]])
    ta("{g={a,b,c}}",   ztable[[g;.#:a:b:c;d]])
    ta("{a,b,c,d}",     ztable[[:a:b:c:d;]])
    ta("{a,b,c,d}",     ztable[[#:a:b:c:d;]])
    ta("{a,b,c,d}",     ztable[[:a;:b;:c;:d;]])
    ta("{a,b,c,d}",     ztable[[#:a;:b;:c;:d;]])
    ta("{a,b,c,d}",     ztable[[#:a;#:b;#:c;#:d;]])
    ta("{a,b,c,d}",     ztable[[#:a;#:b;#:c;#:d;]])

    -- testing _g "%"
    _g.apple = "hello"
    ta("{hello}", ztable[[:%apple]])
    _g.apple = "byeby"
    ta("{byeby}", ztable[[:%apple]])

    -- testing tbl "~"
    _g.gval = "hi"
    ta("{hello=hi,hey=hi}", ztable[[hello:%gval;hey:~hello]])
    ta("{a=cat,b=cat,c={d={e=cat}}}", ztable[[a:cat;b:~a;c.d.e:~b;]])

    -- testing func call "!"
    ta("{a=3,fcall={[function],1,2}}", ztable([[fcall.#:@:1:2; a:!fcall;]], function(a,b) return a+b end))

    print("all tests passed")
    printh("all tests passed")
end

function ta(expected, actual)
    actual = tostring(actual)
    assert(expected == actual, "expect: "..expected.." | actual: "..actual)
end
