pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- picodex
-- by amorg

-- api start with _
_g = {}
for k,v in pairs(_ENV) do
 if ord(k) ~= 95 then
  _g['_'..k] = v
 end
end

setmetatable(_ENV, {__index=_g})
--_ENV = _api

_cartdata"picodex"

#include .code.lua
__gfx__
a000ad11f122b1c231d2ffff8ff7ffff78fd0ae31c426df581af5ba131ffa93ddf86e737e8c6aeff71eaf9cfc5073cf1bc4a884a0f4eef8affcdc9646883a4b7
468e312b3257974159ddd9fc50e1fe701e934f782c9bd11309b83cbc972fb750fd5834740e09c82bc59b8dfef87c1fcff771e879f819b327627ff8bc3898f3c2
15137d86d9abc4d1ec1dc1f52c9b3daafb59957dc3b88b38ec93a82f3cc47b94839f760bf4d01c1d4f358c72f128ec01f2b98d09f49723b0ac61118883998f9b
cf72d18078229c4dee7c1c966d0a1687696cee37541b9d572945f41255dc99e536787d48d1f30009e94a882f37f390d3a3dd9cba88b4acd5fa6b12b3971d7188
a99c6c72705a992c8c1ee04eb4121105724aa86447f8bcf341c55e12c6443e7484c1259ac93bb9475acf7a764e07374e3dae7f88b35903b6f2b08398fc1ed9f2
c385883fc842d9352f6898b1f31190fda42e4de7f269e7d4711fcf359a2c8b182e53a23d5cb0d0c2e26d94ecdbe61002631e8f9d62987223578fee93cb244df4
6cf1c94899096a724a1751739100a2a71ec65f46c911b9248ebcb988d6431bd9b5bd4a9c7b3e4cd472211ffd7684eb2a26043bc127447814c6e597c1824ebdee
f3d0ec1be8e42a5f7e21fbf3891ed9dacb6df2e5d2cdb6e0b294e046324ab54a5736a551c2c9ed43d742cf35ec7f416ebd17059c211f9f39982cd9537a59e051
862e0c4c79581ec6e4121661f6514c2919ae0f39721ecab856292f664e4444cfd2cf2e555861b0fbc32a4a34670d997388cfaf629631f8fce89a40656e2f0b90
bc4841ae74c1949c31bff9c3e6c2cfab20f4c5f919bdb8f3f3ecf4f383f974c717c184a117fc01eff928742eec70b274efb67f9905d9e74002ec32ea5619aeb2
e84e399e3f043ff1e421248701dfd93e4cfac5e771ec37a7b935425637767e13b364e1d48d2029672f671c718b6f74f43c78465e4d7b8ec87ed912acbc9280af
7633aa0baeefd3aff84249723e4c194dde6cd7fb21e7219bf80c35bee194fe0e220421c9b597a3126ae5c1eca732d8f9988394dd7af8cc53ed4fc9fc871efe3d
c8cf1ccdcd845fab7d0f62b7a3eeb7cd3ea8d121d67ea4d9fa6009f9f8ad672ec46eb0701e7dc3c7fe2f194acffbc3378337b712650fc90f2ba2ba19c29fbe2f
610718e709442efaf549cf70d3f391985d24d9a479f9a6fa113dea357959a71765752e79f85c4cecf102b8869eabbfa95acff5f80eb78ea5cfb2526e7ae7f156
5b61b2987352fefbdcc5ef258407fb6790fe906c2e2952a4e7e51ffc53fcf14878e9ac799ecd28faf170b8fb90a3cf8bc9373278338b073bb7300f1ea021312f
e6f39342e8a2f0bc6df62cf62c1f7aec4259972479fcbc187dcbeff5493f46247bdba6c87ef9132c5fa52995049f989f0f8895be9a5cd67c918b5c2afdda2953
86f65c4a3e746e3776517cf5b8f9a2b87d3ef6d144e472a1c9b4ec59b0b2195c2e0fe8972e9f64e812836d1fe707bab11f4bb5217540bef2907629fc7c547ebe
eeb9a1ec560a04b62c7ed5e5935889b9bbf0da2b93179f6689bd45934e495f324a32e9f3908b57429811321840a3eed22bc355a9c79c83a8273b798453a74a42
a3cd6ed6360f226f22d797792f22e77421461eaff333aab89f970f3b3f9a8f5a948ff9bf859bd3579dcfedb3a43d11dde93eeaf4cfe470fe624884e7f0acf1a2
a86e045ecb3e8d44daa77fea46f93818692c0a6fb8e84552f47ac136db1c1922a5552f272401e125c2193cb0fba3b6f64e596795aee532954c3128279e3a391b
dd09bc3498c3b3c9ee44d4424e7ee316765221b89ab112a60407d43e18a774c1513d0fd85677fcfd229cac1c47072eb5ed21fae4f3934c52de277218c23e087e
592aa62b1593abad983d5c3ba8989d932efbc0c98b88eded98dccd9677b25ce42bd483d85bb4420f9515958cbb44dbb06037a2fa3ee28d89273e590e3c9848ce
a82e162d04801e23174429903a6a3e1faec912662dbcf03cd64c5ff8da35992a5a17d9937554dc77d09369b4405e80564e865ee0800e1b8c17b5a9438a2733a9
7b96630e2900e4705e84b87a9822155502b8c43ea1002d756b47a8a7d9a7c945a8b4eca92f32b60cb996945a3883077f58bbf41c069f63172c4c931b93937b93
72ba7c707e8f93293f21e2cb17c22da43bf9354769559a46428817d49c206a6ff53adb5dbd7dd3a479b8c288989f477159697c2342f94876b198f6d01d9339b8
2de04254570019717dc5e4952cfdc1b168cb1642989c7ce0710c69274ac40e4795934435b53258c5b2797bf86cdd723ee0030e543ea884f33073b2d262cbe237
41293b98c1bdac9e00eb41eeba2f43e85e08805bc2c9bc466b904620119094964a461990b298c974e54c80e7d876c094b9b45271abe115ad75e2ae2174810201
0d8e4fd46cf37007395dc89bf3329cc93c7fe9fb3561c7ee745217b4f3b0ba68ede5219112a2e44a3d48041e9ff0465e6414dce8998057f2962a87614ce4d1ae
31887a0e845b9f232c37439c13a2f59796fc035f2e272d25374217fce3e767443eee93af93cdd87630c937d8ccd98dcbe51387a354f2545ba3e74202a3613731
99fcc6bf982e844cfa9c72d39c2c95c10495980b6ccbd0373f2e5731da02174258c9fbf27cdc2ea47e986ecff39167999bae2ffcd3d378517c92a207171fa947
092ee6102d57b32e97fe21c1beddae6c0329210a37dc405544eec4e5e453ed3572c11512db2e9a721122c3392dbc63b33eedd19f5c27a7da7ae542ae7a7e8fe1
2ed48fefe2368e493ee45239e8a6d4431ec3571c3d4bc99ebc894eaec35ec5efc57f67c008e4dbb5b0c7b83fa5dd11e00a0628e7e0566ec937e2b91f6e525647
c348443188c76444f8d04a9a2a2617cd9481a4dd6aa88529c134a233f47201793aec97dc2083997f3052ae982d173d795c4c9e7c93526b27462bb237341fc19b
1d46ae671752a320247523777752bbe9212477d4d0cafe4aa92247e44f05eb45c0e9746337422ed4f6b8264df472612b0198cc3ae8666237699840cd0a486d1f
7fb39d9f7fd1942ba63793c9e613c2f2b295319e0c1929c25a398c3f42d476426e9619e2b6d1f9b89057cd745db1f8e8c6c9ca1d628801ea2142c8930485adb0
858490232801f4211a21e61a21c51ef6219393ec9e627270e011b0d7e82d5ad8c9b49dfc90839ac258f42c8e2bc29694cc1d25125c9c4280372224429944c23d
89965cea8b218485479064e8d28e94395aec726da4e9123c4cec1a83c146ea800998cca3e52ee73d7dfc0c447ae0f71f44cfc57c1e35ff5a55c7a2f14828d154
9a72a4244222e08d483988e94439ef1788eed98b4888221c722bc17c37eacd8bb5e89a764070d472642e8421a43a6b12b3b85288f9e8347aa0834207790402c4
cb141cc02907b882cba73999425e5b19909772e11676d223ce539e833b5bcbf2403db8de2885005846258841de02eee4d212e4f5282164f45c4489871e9b55e7
21b5983217a2c4180395a07039aa2e9aa31f42957392879e01195043be1b53c99c56096def9013f2c90252b296b250994c6ecca4667988549731c9c5aee5e308
1e02cfe132983c493d847cb2c5423c68865737baac740d3b227a637215946f930e25f3e0c59d3c83949162e5af1e8b613779e997ee1700427bb0272d868b379f
9e83c9b3de29578f83e6022256d20478a79462b063e587a9dfcc84e4113a62a617cccdcde71102734432a8273e155567d22eb0c22e57d7354d960862b84ce4a6
bbb1e415112588a4ce7625ed746156b842120931d86627258c248b1842e7204a2e1fe65774bc46484e39a94a2ee77365420767eed1bad9061e9399fc30524934
db238cb41a0968f158743138d24f94721783121c62e23e07473cc6438052f290424e2462b446d82ca1a459acec99014eef4242e42694fda110323722c26cb5aa
a1fe2c9611287225707021707444128c5e6344b6139cb9b212426e94b2d0eab0a2ed73011e8fe872e254277bd64ce43c86dbec834a1c9187ec12acef60a61772
2ba7097d943ffe2f5711d3ae178fcf29c9f1be8ae5e0970872d3197b92ec34adf8cdb31c03be49cfd922e72417832984c974929ca0daccf9e4ca89c91f354a48
783b3fa72be69a8347898239082e3f7231fa25a206e672a1472bfae4b6da0df148271c82faecb0a34276a53796f3107cece70f69543ee97a33d8fcfa3c93e1bc
44c994872b179390cde4c54a1858d988a8c98ab299a3673701eea4349a7c7c1e83be7877033b7b2184ce2dde4663dece9183d88f85be38a3f42c5215e072440e
188b6ddf8f4479f83c90a7eaf2a1070200fb173717b7d6443b8088855fd1b054542f72810229b24a22b8fc96c5883742ccb1e8977a1cb7292cec84cf318de012
a56d7793290ce07280cf3d3fcf92a224965c7e377c4c90134ca9db35982925778cea0029b53aa9bb2c474b595dd70c0e94da65f9794274210751035d9f58099c
53e9e792bd8394a26a1994560f549872b08348179cdc1e874890b21f9fb2194cd9e73529a9900a67def5e7b0226fea56a65f522b4a294d7e63a9462400c96985
d2e7e22eb1a835720b0be84c2b4498deeebf3c17e7699b04240007d6a94a7a31509876513c1d93a6287f83765916161cade4702d6157ccea062e2780fe486d25
374a3849c4291436e926c972e23a85b97050a35784f1053e9863194061b535c2cb2132147c225f964c2b8bce1b2112dd09e874075e3c78944239e4c10746f839
6ecb1842b68fc9b53c49523b98f1886f50341b02d740deac944d68aa0e445f97175f654db5dda21cbd4a523048ff1cbd089ed5184abff1c95e1e8ff9d96e3c3f
96100e02033a2ac1b3cae443fbb99ad3985c74af3fd1222fdec9e17c1d8f8c9965f1b814a301ae4015cccfaaed394578389f68d9ec59b31ff621410a117ef2f4
9cd7f41a7ae3e462d93f60af6c56c3548a14cf073b09be88bb7c11b3592d6787dd7b396cf9f924c2d389cd9dce65e85afdd9a8069cce5451f4462f6f192cdd4d
a32d3720d2473efc303932a3262700cf620e7ee4c1eda76952287a64e50a6a5b4d5e937bc79321f53578a2fe0f33996d6e87d98c3072e0f640ea11b22072b223
171b1e48d247e1900c627a20ec23d52c38e85593bb78551543198c1e6f52ee5c6e57250fea959476f3347bf149cd9d6127b968c945295c2d31a56ea3290b2d60
3b72f1b76d9852846dfc1c4268bba5012d85c7be988cb65a2e7eb0521e931bc577e59b048572b2eb77616739a9d95693da115cb9edbdf96551fb98fad65c281f
f10884bcfed270905c682e1731344a1a73f5e533d8a6fae9f377fb43435e6cc8f1d9ab956af26171e9959f10c5212529cb937934f86ce7a06ba390959317d080
db00297603e475e26a7d9c72e0f2e24ae526b4134cbe49a494e4d537a2485d8d9f424a483772b05377c284bc4522e5c5c3e8f217667793247074a167ac2e950d
942eb0d263d91242720e5912c2e8e2d627c16459c121ac3be9cf48cc079e975929ddfca5143a4441a27da13461a825c522d2e9c06b098537833ec18b3998e477
c5825d4e08292c31231443e8a3448408241fd61f1176d4c778d0873792d08390a3294d382245dff22e8fbfccf340b34302286523f7f25a3f7e902c948fef907d
3ed1caf4ed1f7de0c10236381ca577316f2782437f9bd7cff5c859934bef8bbe788a9aae3c3929de7ee42ad4fbe12e5abeb8fc1583216c0dcf441e3e180e72c5
578fe4bc0378800dcf914c4e8539e875d876313a7b4de81288ce982e846cc9e02408a25a3a29d396fc69f472900209eb8db26b577e5e109c2eddfdb95b570230
98fce2426f3db4414e847641fe94dc174248ea29941d315d171572e1ece5e450392ad713302814d7701132ea882e8c8409689701dd442ba4afec93cbe1efd722
8707412ee65389457c20175786c950aead128c177ea121869447e7720119d8423469c9c2d7adbd3db99868e69cd164e402769a62c8fbb429a05743d53683e825
984c614fb57c30a9946009e4a546da13c124a20f2054b6dc73a70c24d0c70e32947178f8d7092e277d273e179f1f2987174c4e3e56a89e1cd1322891b1219880
83a13bbc6917c6cb64e8a36e8d8899135d46ab5c2e524f2b04fa42cdef2346b2ca855771249472a7dc8b3c1f79e9abc829559a2994a3cb174d780118e091f700
2ec244a9a57a06cfc1d68545cfccd8fcb5de6c9f51a7a38893dd12ab34438cc9936598aca42a8d13a0c99cd9bd1cad11863308cdca02307601694fa294e8637e
07aaaa50133cea625131b94d9b26a5e9b4c7674249ae17dc6918bc5ebc16bc67fee41228a29630284c5068492e4890d13e012d2217905b5d522995619597015a
90d0f205f60b897ef466575d6bac2aa1c39c216af3833796bd00ffff8ff7ffff78fd0aa42bc655fb90977e004fc138ea049f92ace818ff2c76869c2a05384395
2272435be33e17bc18c967091f0dff2ceed983d9a3e9f4167e03ab329af22f76016e80472ed9a3787ec57fc14ceab188e4c78f0d9298a42abe7e9176e8d90ab7
04d349d98357f5e07200247534e8d27e5e99d433e5882bf5049cccfefc7a526e3ab8217fe115018e35eaa9742347e409e8889e4cb217a7d9e7d122a42e3ced50
94a6adc9ab7876337b9acac29e2dddfddb9cc2295437b04e5a7f0f701ea39ef148cfc1456ef0c56fae340c2afbe19e0ad9a4fe8bcaafec29b3517c15c542005b
a3b4d1f41cede420b1596920c94a2520049a9fa1ccb5569400bdcb2c54f41542985aa3adf5b3bbe9b3aebd76b6232a9421e47a42528ab0409c5efb79e374239c
11405ea63087c37c801ef2610779798a7aa1841785ca2598d083cb009442122aab46474e2972112189bc61f2d27621dc4c45244faa0628b82172904db4422069
0f77224075e05eb64e496eef4126b6d97a214dd7203701652400213c55363d2881216517e4c66e0448396114e46d0682342d9bcea47e7742490cf9591a7ceaa7
f480cbbc6285885c014829bb8438c1b44240985625808775f1a142c902952031492e448349429394772d5a19c852c72ef18fc1801e22021e902232e943720f25
5b6883f394f18fd8f05e9f3d3cff7cc15f828537f5a972f28c507ff369e8420ef4ff31837b8d4419155c84f9d8a14650831e279f6134f1aff948f9492fedc504
ba8149128f8ec99b930a5daeb4c3e7a7212779fc7aef72762ec9ef05ae4f17c3498572545ec537ce836df54270808577a3d7c90adfd10707a41c720ebb8a17f7
e12eef738217dc0bf9f83e420798fba1272bd19bf80a51c4747be866e4a8fed60dd925147bd594b51ff89cb342582e74f47074b60e19726ef40c8488d1254428
7f72162034a7888b293f522d1132287427e7e0c1a0ada197c5e714fd77b9363f3e7c82723324112c006b4a944cfd265aa5691712137dc311e0474f4270f2fc0f
c783859421ec5ec97cd0a27b4274929fa4d394f2a13269cd84e3e54615f371c0429e3e0fe49fc9b48268b54ced9242096f483b298448e4a693e4864f118f0429
6f3eb8d79cf6865e4f29e2429aca2b4d699cc1741d401921424993e9e5d61e4ce39a368b18c2c156a1a40d80d49f66209d42e446394b15a3c974732d83ae0f88
3b7b274262c9c1a2d49a4218b1293aa7217823f5259c130c7a7e5f0f174288d5ac21b988d8a339baa32fe54678e416aca0190ddf259a7034e784e4dd244c0783
a4be9ac2b0cae657c7fba82f2e9008a839ffd2cfd53e2cb5f6a665d4a41cf05f9300097aef3c7e03af1242daf0de0d08ffefc7fdc944cffdbf2036efedd3f73e
a793c92146099872f074fef0922df1cc3e0f5247e7e183f108d2e7c5a0c2c00b95a1c6d3f938487a182cf17c506d486e2e350f7861042e579151c5440b01b54c
3abc4ce62238bcfc5ecc59bc8877b398539a83371da00d489d4f2aaed698d2191c168ec98bf5e934d1840f2dcb69832c7d2e30b567e522b21f19a2306307d17b
5057c614172c05876b53c3720f7257a0c90ff8d55b821c5c90bc1a0294c16821c92d422424026e9402f83599a63f5c76c57afbc8e97677586294423b7b42d4a7
b81606f9578802aa6ad96739452b4057327bf1b59f985de821b359e84ee5d2ae0002c1022ec7e50172015e9262fcb8aa8452b4da3b6894c19733bcada5f390c4
4e55197c540efaca1922292c1d5a2e452480a9b401ce8748c15fccec12423fa85b1ae004c90bf97812b703969b010e0348931b5d6759de18fcd37e372fcbf515
908aa434e420248493297ce2f1f8eab11fb84cdbc0d9cc6f833b6e2cb12eb42c2572b02402c99269dcfc3f5384796589599c5e9d822ea1e85a04eb1224728e2e
f23fc0cffc6c4a2094e42d2174746e294072767622193c78f04e4fe6839a93f9f1c91980c7f0188f7272ff7f46f7ff090eff86df7ef8ffe250002150ea87c2a3
78288024a1a454f14ecfe6e40537a09820d2dba5e8322b95208481c1805790a2d5a7a641c9ec62e4ce9f09992903c28c4855ce5e56a2441262804727948fbb52
1d7b0bc1edceea708270c9b5832e11538a9dddc9e7a11e0ce8c500524185b7568695d02a7afb5983517c10e002e5c89444699c768048ad614a2818d2211893e4
5250cf2929c4d07e2311b1bc0868b483b6a0832e1752ac04fb28723e26184c29190691ca37c1b5124d9b8357c2a802fb6959420928c137a95712c072b2e04231
880b2a2d3c8354a429e4e21d4aad88456f9ca2531b920629f201483283959fd52984846b1103aa5ac4cdc926bde3c945b7fcb14248cb44584909120c139e9201
9005699c48489a6261610ab4b68a9424ee609866942534485f4c98cc2505478104259c12d01c96202422141449094202a1bec6985ccb1f978ec9d5230f428bae
15318c787821826b4c5b2a43442484777490cc22b4ad0fea65e44c11414478033254489c169f90016e071992b09005c21e4a2b01be420b58f3388e07e763e122
528895348b2a129e1e1c16dff1189ceff94ccfe3d1825e8f24f5c767f9bf7282b7e3958fcbe786347c6e904e7e4aee96a3844478357a3fe3cf2397c2f15887f5
32bb2e07b7c7f948e473b6687e33ed4b79b93a94ae72b9fe475e93cbe723e1f4d717982637769c9372a84f4272dcfb02e874a022c72fe41ad0f69acc7f8a38f4
7631e7670759ccc314007a4af8f4370f399d77f108712fa83bea011f7ae42d8c814c14ac328b3449e6f360d9e1e76584cf2964e8e217b1f350553e071e945a19
927301f635796791c1385aa45e8f92d221b7422be58b25d5cc178f93ae83ba721be0838bf47283459cb1e55161e4296f2344c28f921486beea331f7231ca49f9
72125d2d54148f72e32544f41c88ab5f7e92c31473baf2275f686d2fdcb0f031243cd41069afea1d1c123de8c137c330367bb0e5621f1a2309ab833ef85c103c
48cf76b45a2cb57c19ad5579697e99158329274919469e09b9fcbc48ade86de443bb9ecd94cd61b62e64b85e2e29954deaf237d2e91e4daec56b2f0e720e7c21
0c695a1add2f4c2e3417f007dfe2395ee224573504572548ae27abb4ce5babb411357e3738e8c2cb17f519e62eda571c42c99c6dbe65519b69e78243f8524745
79fb9720532e37acc17d94c35952374ecd9491ab0b3d28d2daa773d18e82d119821954b4ac19fc974ccb678cc2a47e49114bc95f225143a48825fc73744659e4
2b502d2250442994cd0892c35b83d3f40abb863e9a13961ed49000b927a0fbb4139ff91a8f125060e47afac9f8cf25219a3dac07381ef741cb1242f81f2cf1e6
1fae341f7e88783b98c898e11158b45007df72c74cb0f487e984091e1b1f1cbc2fe8350f0469db9960988412ce0fc9b30937d6391ccb448b8c47c2eaca877833
1730ede01194a68331eb6d440b2d546b679ae3013fd21cb63122dd567e7d473fe8dbaee4d939a883c9d1edd54fa4cf55c3e2947276174e09aa2d5405fe9a7296
e0c114cd61e53219306e3f5cfa29672d376a3e772d2c83cb3f833e42d4668f48292a4ca85b5d78809ea2a71d3e0fc9ecd6d9418803d65956bfacb97a63c9a28b
4e2bec2185991c7cf1f8cdaa1fa81e971d00933bb94c1e8be6c2e4b3375f2e853dad199c8f7270980ce4434a72e7d33e9826662d137e426ed4f2b621d4c13744
07ced3c94d2ec1b414f692a3e2ce869d55c5d4fdcc7490932739daace58fc9dcc157bdecfff01c6cc9947e80422a24e07862f321849ca507cd671e2607e542cb
2e4e4472258d184c6d394ecb3f426c527914f2c5977dc32a57e042b8d7274c64e816cc0f09f2613e52e8c3cb5f70e4328c1d12fc13bde812c8f23433994a48ac
54250fe21e8b63e20ecbbc6c3df3209378a24999f220373b2b620426e062193797e609281f73d5455ecd3d2a172cbda369ef75e88798cd9493b631e81001173c
48399946c18d19f0526b60b42bfa19449ebc485e7fe104a33b4929d55d5fe1226c41612d84be6dcd423ea3ab11d25ca2194c096e9cf310154f0fc917c629902e
7a03f4660d9412c10f3ef8a243400404a3d94b188d7028443a7b74c191783eb2b9a63058cbbc77ea1ad1f8aefc5cf077d9127074ef43ef8c9792cae4ddd15adb
d41f9faa7084cddbcf319bcc0cd327a314dfe4f1c94dab255732414faed2ab37c5127d55a24f194c094bfe889a4017e07afa7a42c7431e2c7a42af2a281908b9
d5f7602461070af2e4c69ef0c2cfcdfb40ec11c5ecf286da813249a33eaecf5645399bdde8651bdebc4dc9feb3297221c22e9490a760d13fe379a4ddb6b7cbf6
762937f2e5fe2cc3989bea42b8acc4adc590c72494abe5a1044ae87ae44ad9e717127cc16221026b397871487e5d389a765e7de97b37b5509ff0391880c40e24
076e830975e2ed7c07a48829efe03a80d0933bba7cebdac99f7e1e9b29bd407b43192cd6d4e2315aa495cc3b4d4ef6987461642162baac84e5c1a317ac85c9c2
aeb31e312082e0fa5ef7713e8ff2e5396dcdd59c8f249565c77e44ba8ac2a9039a0c64fb42a7f52c8c2f9dd1e7f1387b7e97dd961111c4eb1fd9954c9e2c07c2
07b72284b9b8297c3134ba4108dee7d87bcb43c73369370578b08b1f93cd93d05229173967b188c944ca79e0b0870954e19842c963ded3f4ec74b883291f1240
013fe8a3af3a2821e6db9421f2e07452ec65c3fa7751c9c175602f1f87fa318dbeb956ee535b35a3220f67e871a9968f35b5c622379097c6ce72421ec173801d
1c4d8939ecca2e77c3269344f21732f8255f3b987c05dd7ed2c5d6429842230999a3347de76d69832994cd4a59ca29603fb4bd1f3584b84005ebed16dc48c596
c682683969d9c30b2b312ca419e056fd694dcf2d2a81f159ce8b434488d912fe7297adf7ff98f3905f207056e82e959fbbe7a741cf883780349a24f1c81f9fec
d17467374fe886462e5cfe373309b68f940dc99b5424c10314f00c6fe7d0e6946170541dc2421f124dbf98b0f6805e2a83f8093d65e742a4aec1347d0b1f0db3
__gff__
2d30233c83233a7d815a3858fd01050608fe0e11fe141618191dfe2226282cfe2e31323637ff0101005f46493c55fd0fff000200262928414171607f5978525ffd0608fe0a141c1ffe2226fe282c32ff010200494c4b6464fd0fff000100732d1414190a082c5a3a815d38fd010506090bfe0e11fe141618191dfe2226282d2e
31323637ff0101008c462d2d32fd080a0f2cff000509282d23372884437f575b95fd020406090a14151f2022272c32ff0105094b50465a4b7afd0fff0008052d32371e4b166f5e6cfe6e68fd0306090a14151ffe222c3233ff0108053c41462855ff0108054b50553264fd080f16ff000b0823463719376aa49a956d3ffd0306
__map__
82c85c5e7bfa490520774e957b64124b1a675daa1f91387e124ee9c18e1dd3f67424121c3f0cf91b3f0241a7b1274e0593948913204e21c3c3b8bf736fb9d7888699f53b127ca0d222477092918fc054e7b3f21f9381c3f079dc8709cd7103aafc7df79913973606573e215039e1f51c7925bd4d24fa6b333eb5e4e78fc7613f
06b06b3c47dc4957691f8544b25bd128fa25708945d509cc6b3d9676e5e950851dfe1d36cf35fbf09c4bc268b7e59a152702fbbf014e21ca0e7ce9248e71163f09f92495ef8f0cb387324ae043920e7cf2373aded04ece53f34721c1e5705713be51d15f94ad22af7a724771275d5850546d6cb5c704da6f2a69d769cc6e799c
bb9d77272e42dc7127bdae8a4a906ee7522a4165eb49775a2e9c2cc8e427ab0e3872994736fe1d2de3161049c3bf11a89cd593873f5a924e51e2418950b2f5d4473773222241f8248d8a7141048ef8e390399cc71e4e780208f275e7e139a389cf1f844e694fcd3b31518e4ae2bf137277dd119b892f5384fc32704b93e9ccd1
61f44221964e637dd4c36dc611bf0e2516fd25b5168e395727e31d2bf07138ae0b48ef09934e9643a9c849d3a5c7646a376fc223c39110edd4f7de9614930b27deaceb8210433d71916de526215523eeb46b085dd338a3aba004ca9e6be3ca7104e24e1c71a1f2bf02a25d78453893a2f6903c892dbf97442484f1fc12259c22
27aeaad69f1de78e13992a7812a16db4bd42db3b2576cefb9668916fe33d00fffff87fffff87dfa03538e2294c7f69dc07eda0fc25599f8b851ff8e72ee57e7239dd7509d3f1dd01ede875d7448f531fb3a8759dad8e6d88484796b069dade14916cf59e2f7ec278f2f28ee4f4d3c49f7e0b24275193c702d7d5c1892faf625e
1c3ef16e944f8e378f1497df5cbe843a7578e3ee4f78859677f477939e6fdc5e14944ddf12c90489c4fc24921c84728937e0e13c9f8d3a0bcf8e2733127897efbdfc3875f3249244a4eb8b6baaa1c2dbcb5e38d2710dc6e92a6271e84a2412c32f5cc5dcde091f16bb327a92749f4d7d91c489526cefa248964bc1ab89387744
8e1dd485e3768c89c35e340b12c8939894e1c7e1c22f3043488631262bcc44f993974974134ae024476438a784e2a1a8869c27e1dd7dd1bba938eb99d33a24915cfd3d2627490e78c9acc44da6897a48fc61922f3bc3ed4cf38fab78d677df5611cc2c8f524f24dc1c7e1cc4946e213a9a472444f2f3093c22d3076e4abc94cf
b89247488ada89da3f1fa120b3bc9965716f51210ceb8bc4703465859b8d78e9717e5731e24e1c73cc939e2e9a8733817e9c24e639b148bcb66a5b62ecf9c5e212ebd7293748f8a271ccb92f5f865eb8ce27d4178ebaebd1c056ad9a791b5aadd59699f08689465711104f96c915895027138624dc2b0782de89cac2a420044e
b9eb4033b10d0a4941d307b9562589ddebf0a9ec0bf8f05e38c4f22400a087a70417971f81da49dc4a2ba6cc76810e609f87a223973ef337b2c4b685a9c243da680ea7e37aab24e0426949097b49cfec9244bc12d5fa282c91e9f92596a1c45e17958895c324113dfa43d9c3ff49ff81c057e387f29a7e43f2f15387005e0ffc
f3d7e33eeb27627513527e2fa1dbbe0e5d9d9f944688e9f943b4e4eb97cf622f73df0709d48253c79a7e15470f23b63896f50bc6fa4f2c9167c4f54e57349c4e2c7945ea4e5e69cacf267e43e5111ccf164ec47de2db3a88eece7bab5d2bb6b79f1271c162cb365ea069c4ce357524ea4e2cfac5a312a7b1afe3f875240b3f04
7988f799ce92f43813838d1dad9c5a76442a47658b6a5e78bf8eb104e644b642dfc47b2549f7e4808038bcc3d9cb89bbbd59f85327e1cd5bd490db4a86234bd13a90be7e2736a0e1cc593dd6222602f1d6284e08471c434de2712cb99626d5297496a9c743002a672dc9ece37064908e88916444ec730449d11adbcfa215d27d
2a689dbf16f7dc8d80b6787c0921e98cb5f8c91a7e09389e70e2ae9a24592c90dcd5a925997cf273f1cd60122aa1169da73a4e28a76e1ba9d3c64de709cced924b69798a0fc42a1c1071ef7c50a57b885857e0299787e1a7739bd797f05e2667085955f81c6d79e22ee3dddf59cfb79122f2b016327b6f08d4635fc389fac4f5
e690eac899eb732d8893843888d1efbc8d2c25293a08a0266beecb64913bb5397e1a6911d2f5d3134e04e5cd11239a954c8f13b10b2bda992c6ed22491c3463109e09af0943710410d33277c7538611ede2132fded086709854cecfcebf28944eaee2939876250cbfa73cd8841222426dec04ce57f18bc9df28a77c71efdc4c5
91f8c84fc9a7e4b3f265fddbf7783943b0e6bd9e4e191d0ee59f576a8a2d11da772123dfca7afce74e5d0b25edd913cc97226aa4eddb9c27e4e67a94c2127908a100ddf77e1d3b876f01d2673469272a51c1c045e4eb58f23c4b3417c7058416bca271e2cf259d971a5861d71277c978f6f0a952d8d3d5dd380e9155dce0e07e
251dc95cf0e9cd995f5bdf519123c5e8dc696bf09e3b91209cace7f2081d7e1bdc72e64847e180794ae8e091c4815dad8fbc3a9cc93832aaf72753823b3b1cd99245e38963a3485d7f1f1b84008d91370139e4209f6978953f08e2b874e6403a96c77a21244fc1d4ea6b89cded326f7f2e9166a42f35927e1df0124924ec44b1
a70ef849270e3dd7a93a216afe3c5933b13f113c9648e85ba937cdcf9239f6fc848e2063cb18584a83b16d0e52c1283938ddc38eb7e1212de9d24927b7ba75389ad2491c17846b38f63992849ca9c951604a6736224491f673a5dc387291cd6e259096eb573ae02492a966a22d798ec955cac33e679979e0e7aae5e4f62e8ce9
6c38dc3efc389aa7a979df844a598435ae924e7a399cf765abdfe56aa7124b5d15ef3275cf6b91cba892693952544b2484aabecddaccd6ea88a8c38872ace53a709a4e7b1965b7268bc4d7ac5e922cc82071c584395a712f0e3c9a716afb3692c13d891d3903ae7a9387104cbb38413f0014481f8cb351a38e44e670cbd52752
3979e108dff6baf2e7ec4b9c2eb2affe14d2304e0f389af122c9cc5b0b51c7ae7cbe921c898d1c4f10dff913f071c243a17b93ce1b711ccaa769ecfc3f03a8f3e0d2b8e783b4e9bff545f4e88dc1f83a1fb88bd27113c7d614101614848203b4fc5f53f009fc9e2fe7a6a501438009c000410a82a582015f7600b0a7ff75243f
c879248002a425f79ea2404283ffa05c7f453f277b41c2f4a82abfd3ff1252020b40a0208093480289012bf19441a890ff4e8fcd3ff72e87e12d90ffd4bfffff0b39bf938e5274d9f8a7fe521501e01042c0420888dffda48cf73ff270e071250a2988521fff4587fe3e520e1de7e3a08629fffcd3f539875090a74707fff04f
03bfcc1f8407642d14fffd4f3ca3f484239fd93f599fb90ffc40ffc940e0ff525fa3f8a3fd203ff290e13ff12fff5df8fe1d7d270e9870756ef6c4732fe1245bb9b107f31bfe61f82d164b404a37e17863a127e024388202c7dfb990700e01a54320b5e7e01c0dd80afc811470e7ac398473c90849ccfe091dc2c790b1f9c258
5249dc25dcb5674e389d393c3fd77f99f91d3dfffe24887c52042fe20d3dbd1d1c5be79d38e28134920d3b0fdec9210e810843f3393fa8bf94be6a71d4f9c1ffb0ffec7e4730c787e561a1d43887f6dfdcd3f98749e99bac3bb61c02e43fc6fe4fffd6453f110fed07ee7fe63f34ea4707e40a7f07f27fe53848fc10a9d1ff1f
ffd2302d117aa3985218ffef0fdc1d1c000fc8e60294ffef71fc43f0053f08730e21cc3ffa9ffa0fde1cc283807f6bfb9219783b29d27f8bc40710d0ffe0179050720ffce1e51001014ffd276130860610e887f880202928007fe5077238a383987547fe08e61138290e21f898f427e50fc4ea8fd8f1bfcbf89f914f043f23fa
87eebd0843e29c1ff88fffe1af738521d0210fd672fc4fffe5d89a1d438a3f3b150fe6ad2fe62cb7ff4c31f97023ff343ff518ff02d0700a3841ff9351ffa014e0fd42e3f183851f83903f0e4a298fde14021a1fb2f07e509a8fd0fc38298a53f2a303b801f91fd12c3f53f0a4e4e647e147278210fc01cc290c0a9ff94fca1f
89fb44c7d241b005141ffe61ff94fda1cc28383fd4ffc2dfb113f53d538ffe47ff689fb1fffc14a52941c90a28c421fc9fffc0448e4e0e851f007fff6451443f20700ffff1d141c1e1c087d23f73fff860e01c03f7a063f53fff847ffffff8390c5294b40a5294fffed1c83807e6700fffee1c94a5310e01c03fffc674700e01
d43fffb45380529f14e01fffd93ffffffc153fffffffffffff80a0ffcff877fffc9a199a289a3a4a5a68800b465b38d8e8f60616297989d9f939495a7a8c0c1c2c3c4c5637677adaeafd0d1d2d3d4d5bdbebf909192737578797a707172b1a9b2b5b6b7b8092cbb64da5dc4939e17adb9ddf9efdc3f06fc7f2fcbf23f35dfa7e
b2febfb63713f7fe136e1c27f3abfa93fbff2bfdee7fdff83d7b9ece7ff0ffe2ffc7ff93ff2ffe6ee7e3f8fecffcffa5ffd1ffa5c1dbdfd26dd4ffd5ffaebff64e7ff6ffeeffdfffc3ff8fff2f4f27ff3ffe95ffd64ffedffdebffc7f09d4fff3abffd7e13ffdfffcafffb17a9fffbfff815fffc1f6bfff85fffc3e1fffc43ff
f87ccfffe2ce2ffff1a3ff2c8e27fff1ffff90000000000000000000ff0010012188001d060c2bfd01fe03050609fe0b0d0e11131419fe1b1d1e2c2d31fe34ff0008052d31312d4116696a6b6e6c464f58fd030608fe0a14151ffe222c3233ff0108053c3e3f3c50ff0108055052535064fd0fff00020027342b41327160a414
565f3f58fd0103050608fe0a11fe13171c1ffe2226fe282c323336ff0102003a403a5041ff0102094e544e6455fd0f1a1b34ff0004002c30412b32622880570c98524ffd01050608fe0b0d0e11fe141c1ffe222c323536ff0104003b3f503a41ff0104004f53644e55fd0f1a1bff000b002d1e232d144f70ff010b003214371e
197cff010b093c2d3246506342045b6cfe6e74fd0206090a0f14fe161dfe22272c2e3237ff000b0528231e32147053ff010b052d193223197cff010b054150284b2d77551454854efd0306090a0f151ffe2227282c3233ff000109282d28382386774304784b42fd0206090a141ffe22272b2c3234ff0101093f3c374732ff01
010953504b5b46fd0fff0001001e38234819a385a078524ffd0608fe0c0e1418191c1f202227282c32ff01010037513c6132fd0d0fff000109283c1e461f7766864e566558fd020406090a141f2022272b2c3234ff010109415a41643dfd0fff000500233c2c37285e7a9257535056fd0608fe0a14151afe1c1f2022282c3032
36ff0105003c55455041fd0fff00060023371e5a3283197718274578202d527258fd01050608fe0a101113141f2122282c3237fc35ff0106003c5a37645afd0f18192027ff000700324b55281e9e2753a44b3ffd030608fe0a1113141afe1c1f2022282c30323336ff0107004b646e4137fd0fff000500372f342928489e5752
533f4f58fd0608fe0a0e1418191ffe22282c32ff010500463e433837fd070bfe0dff0105075a52574c4b08fd01050ffe131a1b26303536ff0005002e3928322848074e85534d4f56fd0608fe0a0e1418191ffe22282c32ff0105003d48394137fd0bfe0dff010507515c4d554b51fd0105070ffe131a1b26303536ff00010046
__sfx__
0b0d0e140fc770001000433065623c01320537090351f54517d67060400a021170611f877220323e3422c0133f700020001a1761057510d670f0713f300040002801328055280160f2403a060359413d33009877
2cfe2e311d47120012280622e01335c770102000404015041a1133d700054013e7111a451230333f700044101a5251f13406d670fc770006000441144701a5461ec6701420060403e35011877144611f87723042
2c303236324333f7000c000284121e446385021d801235571d1273d3613f7000c000370132d04707e670fc77004100003410113234121141105636165433d70005030088770a011140513e3611f0022241226042
055069413f70003000101260656232c77014100005502205374043d7703f300084203245423042065242b1752d1762c105061563d710064400a0213e3311f87722062324133f70008420011553243315d7701040
7324814f061263d3400fc77000200504228412061262215702a700c415105551ed6703030098770b4600e021154713e312280623241335c77010200500506504241473d7703f3000d43028005241211e4721a067
fe2226fe3d700060403e35011877144511c47120012230322c003320333f7000d43037475335122dc7701460070052e9102d4333d7200fc770001000013155331a5043754031145071151fd67068770805014471
5080fd012806232c77010100040424134291053d7703f300040601a50401570284610f260181641d1273d330088770b4600e001140513e3611e877220323e3422c8772e403324233e7333f700040601f5542e171
0608fe0a054701187713c770003000441230342d4753a5322d455321650fd67064400a021184411e87722062324333f70006000320631f13438d670fc770040009023015333c05324637030741655425d6702020
584cfd06144713e312270422c0133e3233f30001440234252d454234373102126174185263d320060403e3501f877220422b062320233f700014403c076061263cc670fc7700020004042d4332d0340d4402c026
4b3241fd3e3400a8770c070100211f002220423242336c77010200a05506105065753d7703f300050001010532441288613a16709667132431dd670604014421184411f00222022260622f0133f7000500029546
1518191d0fc77000200007101126284620d035249601b9000fd67064403e3600e0211e87722022270622f403324233f70004050324753423415d603d7600fc77004700507123071101262a42739d303fd6706021
202224281f002220222c0722f0133f7000f4202d0132d47533d770147005063011632e9103d700050403e3500f4013e7112304236c7700460074122d802061713c52414417045743ad67060403e3501a8771c471
9d4741402c4723001336c770006000063304622a055365611326434565384273d70005030088770a4013e3211e877230422a0623e3723101337c77010600042509134035173d7703f300040001e4461a11319067
8c50fd0f169413d710060403e37014471200122c0133342336c770102000433026170b1133d7703f3000600028071320263747227c101c1220f1573d33009021184411e877220622d01337c77010300006332034
4c5258fd28c77000400c0632800528063142312c56629502351763d33009050144613e30222022250622e47232c77010400c4751f5253746707d670f4211640236c770043000013324752304214c710ae2011135
36ff000301420060403e37011877130513e3611f0022203228062320333f700070003c0052e56232c670fc770041000013385231751205c01056440a13708d6701030088770a4013e3211f00222412270422c013
282c323300013295740c512124003b8773e4373d720060403e3501141114471200122343228062320333f300010001a5330b1713c05705d0007565105553d70003420060403e77011877140413e7511f00222032
1f202226350333f30005000284041f5123c47204277092220f9403d3301404119471200122606232c7701420004041a1473c4253d7703f30007460105251f5411e440165300e115075643d33008050140413e361
31323637280623001336c77014300d44602247284623d700054503e71135c77004000085705420324460ac10012533d1451a11538c670142006040094503e7701187714031184411d8772342226042290623e372
202226283f30008000015333316324156051342c9772e146049703d710060403e3500f0213e3311f002220422c01333c7700400004461f1051a1421923501015171213bc6705030088770f4013e711188771b471
fd0609fe2c0033242336c770002000071280343c034225370c0353e9413d330098770b4600e0211f0022243228062324233f70004000374041f5251fd670fc770002000462031633f013375300b2740d55512526
4b5573640e0211f0022243228062324233f70004000101650112410d670fc7700020000712d4331513422d103d5323b1670c4743d330098770b4600e021184411d877220422c8772e4033242337c77010200c063
2227282c3d77027c7700060000422d4041a126320373a02703a103d70005030088770a4701187714031184411d877230422c8772e4333f3000b44006176105463741437510242020523538d67064400a47014471
181dfe23324133f3000a06001113234751f170119313d0403ac3038c6701420064403e7600f4013e3211d877230422c07232c770003000404135432952519c103e0573214716d6701420060403e3500f4013e321
0608fe0a270422c8772e013364333f30002000015753946515106082773c477165753d70005030088770a47011877144613e30222412260422c072320333f3000b0000156724525374102426701d201302400d67
0f6256170f40114471200122c013330333f300010000b1261f1760654014035071150fd6706877080500d8770f0413e7511f0022203228062320333f300040001405037005144741be7701020094753d57411126
303097ff17d67060403e37014041194713e312260422c013350333f3000405002625101631f1160d477084061a16018d6706430098770b0700f02116877194611f877220422c0723242336c77004000000330003
72fd090f004000043337013374040943505215381450b5743d33008050144713e312270422c0133f70004000026043c4042e11621961249200cc67094500d8770f4233f31006000015043c8102e541155372d044
235a628d184333f71002000019103c4042e10614035319401fd670947026c7700400004043c034284543141621a12375570fd67064400a4603e77014041194613e312270422c8772e01337c77004600441228026
3c73695016564002603d330088770b4600e0211f87722062324233f7000d020061633d53333d67074701141128c770046004071101553746222135242463f0673d330088770e0211f87722062324233f7000d020
0e10fe1406d67024100547011411284133f3000d44010546019103c470094351b51437d670202006050144311f87722032274522c01334c7700400008022e5041e4040f0503c162080640fe6701420064400b877
090a0f14160413e7511d4713e322260422e0033242336c7700050090551512615567215370e46025d6702020064403e3600f0211f877224322b062320233f300064401a155151263dd1037541261173d31004030
191ffe22184713e312274523e7623202337c770001009055241551a5672b4371650725d6702020064400a470144713e312264322c01334c77000700044200562320130f431055372d00516d67060403e37014041
313236372687728062324233f7000e0003d0250113406d6707c77010700945506675101263d31036c7700060000562e15502a510f6063b561026321d1273d700050300887714031184411e87724032280623e372
001000003f3000c00024126241262456123400172433d3103e3611e877220223e7333ff7700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
25100000000000000000000000000e45015456134560e45524352243521f3521f3520c4000c4000c4000040027052270501f0521f05200400004000040000400004000040000400004002c0522b0522d0522b052
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010400000064000640006400064000640006400064000640006400064000640006400064000640006400064500600006000060000600006000060000600006000060000600006000060000600006000060000600
011001001f05500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
93080001006200062100611006150c6020c605186021860524602286022b602296022f6022f60517602176050b6020b6010b60523605106002360511600176002860000600006000060000600006000060000600
011000001f055000000000000000180550000000000000001b0551b00500000000002405524005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
02 087e0a14
01 7e161c1f
01 7e22282c
04 32337f01
00 0b083c5f
08 501e507d
02 0f7f000b
00 053c3732
00 2d281d6e
04 636d156c
00 745b4f5d
01 7d06090a
02 147e161f
01 7e222c2e
04 32377f01
00 0b054641
08 3c5a5a7d
00 02040f1e
02 277f0007
00 000a3719
08 5f2d1a24
00 4b1c583f
09 7d06087e
00 0a141b1f
00 20222c30
04 32337f01
00 07002350
08 3278467d
02 0f7f0001
00 00282d23
0c 5a28241e
00 7a10573f
02 587d0608
01 7e0c1418
00 191f2022
00 27282c32
01 7f010100
00 41463c73
0a 417d0f7f
00 00040032
00 34303732
02 621e745d
04 523f7d01
08 0506087e
04 0e107e14
00 1c1f2022
00 27282c32
0c 35367c0f
01 7f010400
00 50524e55
0a 507d0f7f
00 00030028
00 50234623
08 7a511305
01 1e39673f
02 567d0105
04 06087e0a
02 107e1214
00 18191c1f
00 20222327
00 282c3032
02 367f0103
00 0041693c
08 5f3c147d

