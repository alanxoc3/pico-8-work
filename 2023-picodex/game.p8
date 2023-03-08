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
a000ad11432285c214d2ffff8ff7ffff78fd0ae31c426df581af5ba131ffa93ddf86e737e8c6aeff71eaf9cfc5073cf1bc4a884a0f4eef8affcdc9646883a4b7
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
5b6883f394f18fd8f05e9f3d3cff7cc15f828537f5a972f28c507ff369e8420ef4dffa2cf4ac379317f68b98223aa819f3a1435e10e483e5758c2b81ffe135bc
7df5c809d4f6e40255e89024f1e898bc39aad0e54a3b7c7e1a7294a7afe759613979d49f878e7227edec7229b840cecbbae8d778a1bc4e081eb0e07ef63a2bf0
9cad4400fe97fd4a19fc0eaec1f57c8bfbd8acc137c6723e8f9cc122f66cc9ca78e6368e5035707be846f446698f8144e48ad67da565cf362fe49c1287193d1d
1dad8f42949f390f21227047195277f3307572f159fd2982293f522d1132287427e7e2c1a0ada197c5e714fd77b9b63f7e7c82723301ea2190d2a029e419c3ec
615ac984c457fc4034d9d39010bc3fcff1126921443b9b7613b96907e54109e0c27b7aa62e3269cd84f8b99941f45c3c90a387cf31eb76f158493458cbd4ac88
0d7f44523e2a6dc39a8f1fa293e4864f118f04296f3eb8d79cf6866ed742b898925c29da942611762d41cde74739e755c62f3ff6e4125fb4d14c90863e822d65
0885735e89b026446e85b5541959a76aacdde51110c3772224961d2c4aad6984119ba2e92a62e046eb44a5b4149c43f5ab3f1dc288d5ac21b988d8c2d9b5fd29
3f42a337e00559321aaf3746948c580249d943523218299b2fb420beb1daf5f22ecb4b31105172ae80c0b61d7b0e5f98d6db9a95633340f34d4ea154f34fbb0e
decce38895b234bf4702f3fff9737e11f373ef0c89ff7bf8f58fede87640994222943c3ff1cbc37a84f733f890d5f178e8700eb0f57920b8000b95a1c6d3f938
487a182cf10cda86e4e652f3801746e0721519554cb41050cba4c3cb642e82c3cbefc59cc58b78378b79a53978d301da80d4d9ace26a8d299dc161e198bc589f
4e134df8d0b29c36c8d2e702537b562e22fb91210a337610bd0775654c71c15270b836352cf720b7057ac3327dd6a4031724278e84217412487a439801098893
2984324d6ea5db1fc5ab5ed3cf463fb3cb92239452d99b22b64db5b040bfca14505543be4ba95a09329ad18baffdcce4ca2719cdca77221ff60510001e70312e
0f188378929463c7d52514a2d5d6c92384be9ce9e52d1d8fa47622cae8a3f250d74698416961d8f2212a01442d8578364c027eea66179072c955da8027405e48
cf93b09d38d48c78104812dce8ba4bfac6e09ffeb3f9592eaf88d42425a1072121144d699307cfd707fdc8e5528e46ee761b5cf96301fd21e5211983a511401e
c46be6f799aa44ab4b4ceaf4e29c74014d57a2501fa011f37411f789766ee7530221a4670929a3f3430912b3b39341e8c183f7723a175c94cc8fcf4e88340ec7
f01c93f3ffbb32ffcf7870bf74fec3f79f07820009d2371c164dc30124012d2582ff723e27273889458411d6ae4d17e1298c21040c0e348a9425be3d054a6e17
2377760e8cc49c81614624a26f272b5922013940a39342cfd9298ebd8de0f66975304930ecd2c91780a94dc6eeecf3d0070e74e20021a8c2d32b4bc2681d35fe
acc9a03e087801f264422ab4463b4824d6b0251404699804c97a2128ef949462603f9980d85e0c3452c95358c11783295e02f51c311f1b042e94840bc06d93e8
d209aec5c9a3695401f5bca4298414e093dca3096831597821904c85159616c9225a947271862dd644a2b74659a18d490b9471882411c9c2cfea9c4242b58089
55256ae6e413d6f9e4a2d37ed82924e52224ac84010e814f4988408ab4462c244539b0b005525b4d421a7730443b429a122ca72e446e9282a3c002924609680e
4b181211020aac842101d0576b442eed87cb4fe4e2998721c55782984e343c9841b526a51da1221242b33a486e1152de8775b2722680a8223489112a2c460bcf
48883783844958488a61072d958057298524f91c4f83f3b1f011214cc21acd15014f0f0e0beff80c4efff42ee7f1089e74f22c21bf3e4bff9d93349d2ffc5c3e
3f24e1f303f472d37237942d2442a3d9f3997f1e399c06cfb22c9fd1fd3138bd4ecf2217bbc57393e95f4acbdda1f415c3fdb77a92dc3e2f092fb7bec8b431b9
e3949cc3751a12e3d69f40278315317e295780b6d7e476db44a1b783b93f3b48ea162e8050d342a7b7f948e9bc8bcf00fb4955d90778d8a36769046c22e015d1
2cc13a178f438e3f2f2b744e29431737889d8fa2fab178a0d4c298948b38a7c9bb0b8c4ed1a275f21c9486399d52295f2c29ee36f81cfc195c95d388175c2c97
932c6a84ad0f8a2b47791b2912761ca4b074d517f99883d9464a9f93e0ea29a2f09c932f2922e7c0547dfa93942e90db95b779ca637b69868587a961a186c07b
5d67e890e0c9073e990eb1d18ba51f73d89049581d7cc1e782e0c1723ea3d5e221edc3e82dcacb7bc3ac984c39494ab872c448ede7c5624d672b175afde42ee4
0e3bf52143f5f24129ec5a17b799c67fe07a255e7b7910f3608369405bd2e0fe697221b188b7789e47f9922731aaa930aa497235592df556da2d85a8f9b3c9c1
17563ea8cfb87751b6ea90426ee47ba50bdacc3b1f144a97b22a4adbbf8c11fa31e9056eab944e9ab2f9622e84dc5d68c911d6b61d8bfe1404ce9844a8a2e545
e8b7ec523e6b142675c30ad84a7e9a019a2a45246997abb342aa5709e21901a24229e44e10945e9a1caed750bd74d194b8f4a0868440bd0955af95f8ccdff01c
80822357d3c74ef72e0959e4e93548f1b08f5a1e9042f7e801bf77f825f1f8c344d3c9c446840fc8a285b2789eb36e02a5b74c2f4478d0f8e8e0f54927f92840
5bce8c43a414f076481ecd38b9c6e9d02e526c341a5657364c93b988e10f07a8b4150cd96f2b526829d23b5b940f7899e6b0859961bef2e3bb7ac957fe2547ce
c9154c0eee2ffe2a752e9a1e2794b3b3f842586529a278d794b384072ee00e2b1fc188f173e9d2c7396b39d973b1eb69115c7e997c9122b6734c4259614255ea
ca837494356df8f1486e37c68e4a1438c6baf2ed45dd934b1e557c526907294cece083bfee55875c07cb8e08c19ddc2e07cd736172d19baf1fc296de844ecf31
384c0e72a12531fbe11f4c1b3396813f293762795b9862e8932a8367e1eca617e0520a7b49d9716743c6aaea62fe6e3248c99b946d5ef2c7e466e8a3de7ef778
0e3ee4423f48211512703439f1984246da83e6b3071b83f221e5172722319ac6042eb6942fe597293621bc0a79eac3bee915a3782154eb9b263274036e878471
b817297ce1e5a7387a114e86097e89de7c016c711a99cc2d2456229a877107cdb17107e5563e96f918c13c59a4c47918939d9d3102137031849bcb7b841487b9
eaaa27ee961d831ed6d9b4f7b27cc344ee42c95b987c0088831e2c94cc2be0c6847829bd30529d758c2a475e2c27bff802d195ac94e2aeaff81136a0b0964257
bee62117d9d580692e59842e843746f9088aaf87e4836b94401f3589723b864209e887177c59a1200202d1e4ad04ce301c2215bd3ae8c03c1f59dc5b102ced56
bb7d05e87cefdbfda4e7323affa1f746c3496d72e6e82dfd81e78007e9e7904d6ee706d327a314dfe4f1c94bab255732414faee2b90f8345e0a79a754aea4535
eb3242111a4d5f4f2e321e7ae05193725d4141c8406ebddc2758c98ab02d51a334bcf373f21c8307a86e17b75436400778c5b7f549aa2977b3bb77fa2e6d01c9
fea3297221c22e9490a77036eb762d3fb257daee1fdbe994cc37eecf328cb9a82db4acc4adc590c770b2056f7ee1a42d504277a385d9e717127cc16a8028ade4
c1e535f965e07a312fbefcb59bda28cf7c9c0c48620712063937317a1dcd212a42fb388a2c30e4c6ae1ffeba76e3978fe6466b1cd2dc424454428be45992baa8
1702e8c23a958184a9bc2c84e5c1a317ac8599767297312082e0fa5ef7713e8ff2e5396dcde593f381b4a2fcd9e5d6394d9e796d518380bd4ef8d48fd5932f9d
d1e7f1387b7e97dd869411c4eb3fd9954c9eac07c207b72284c9a65c4961219210addfa1fe872ee391ac930178b08b1f93cd93d05229173967b1984d2e524689
07e65294c1d4120c2994b9ea3d7d7e325a17522ea414f0833efacae88094ab5f4284cb93c17993842fdb2e0f2c82af1f87fa318dbeb9e83ed42c6a47540edec1
f2433d0f6a6b8d446e212f9d8de4942c83e6118bcc7c51d05cc9e47ed8529374328b1bd7b46dec72d13477c95b374b294209ac2446ee6228c32e21779252b680
31dc72f25cd422c21124bf97786311175a0b2a91f0729176cb44f494a2449369e7a53d3fa48806e7752b0e0e8498cd6fb4be9ba0c4def31ff9ff3cf3b06f1990
d1802f52f9b97b7e1af48c780348a349128ffcf5c91ebdba93cf42a691831bb7cdcc4ea1ef234772e2150578c001340fd3f9b8d52954181d47b490c38457e32e
__gff__
48394137fd0bfe0dff010507515c4d554b51fd0105070ffe131a1b26303536ff000100462d30233c83233a7d815a3858fd01050608fe0e11fe141618191dfe2226282cfe2e31323637ff0101005f46493c55fd0fff000200262928414171607f5978525ffd0608fe0a141c1ffe2226fe282c32ff010200494c4b6464fd0fff00
0100732d1414190a082c5a3a815d38fd010506090bfe0e11fe141618191dfe2226282d2e31323637ff0101008c462d2d32fd080a0f2cff000509282d23372884437f575b95fd020406090a14151f2022272c32ff0105094b50465a4b7afd0fff0008052d32371e4b166f5e6cfe6e68fd0306090a14151ffe222c3233ff010805
__map__
42dbc239688e23e434d59e912ba8710f5ec3c740ee0b217179efe9241481dd3a55ed90492c699d76a87e44e1f8497ba70638774fd9d0904870fc33e46cfc09069ec49d38164e52244c8138870f0ee2fdcdbec73da21a67d4ec49f28348891dc24a463f014e7b3f21f9381c3f079dc8709cd7103aafc7df79913973606573e215
039e1f51c7925bd4d24fa6b333eb5e4e78fc7613f06b06b3c47dc4957691f8544b25bd128fa25708945d509cc6b3d9676e5e950851dfe1d3779e6bf7e1389784d16fcb342a4e05f77e029c43941cf9d2491ce22c7e13f2492bdf1e19670e6495c087241cf9e46e75bd209d9ca7e68e4383cae0ae277ca3a2bf295a455ef4e48e
e24ebab0a0a8dad96b8e09b4df854d3aed398dcf339773aee4e5c85b8e24efb5d149520ddcea45482cbd692eeb45d385991c84f561c70e5328e6dfc385bc62c2093877e235139ab270e7eb5249ca3c48312a165eba88e6ee6444483f0491b14e282091df1c72073398e3c9cf00411e4ebcfc27347139e3f089cd29f9a7662a31
c95c57e26e4efba2337125ea709f864e09727d399a2c3e884432c9c46fba986db8c237e1c4a2dfa4b6a2d1c72ae4fc63a57e0e2715c1691de13269d2c87539093a74b8ec8d46edf8447872221dba9efbd2c2926164fbd59d70420867ae322dbca4c42aa47dd68d610bba67147574009953cd7c794e209c49c38e343e57e0544b
af08a712745ed2079125b7f2e884909e3f8244b38444f5d55ad3e3bcf1c273254f02542db697a85b6764aed9df72cd122dfc67a0fffff87fffff87dfa03538e2294c7f69dc07eda0fc25599f8b851ff8e72ee57e7239dd7509d3f1dd01ede875d7448f531fb3a8759dad8e6d88484796b069dade14916cf59e2f7ec278f2f28e
e4f4d3c49f7e0b24275193c702d7d5c1892faf625e1c3ef16e944f8e378f1497df5cbe843a7578e3ee4f78859677f477939e6fdc5e14944ddf12c90489c4fc24921c84728937e0e13c9f8d3a0bcf8e2733127897efbdfc3875f3249244a4eb8b6baaa1c2dbcb5e38d2710dc6e92a6271e84a2412c32f5cc5dcde091f16bb327a
92749f4d7d91c489526cefa248964bc1ab893877448e1dd485e3768c89c35e340b12c8939894e1c7e1c22f3043488631262bcc44f993974974134ae024476438a784e2a1a8869c27e1dd7dd1bba938eb99d33a24915cfd3d2627490e78c9acc44da6897a48fc61922f3bc3ed4cf38fab78d677df5611cc2c8f524f24dc1c7e1c
c4946e213a9a472444f2f3093c22d3076e4abc94cfb89247488ada89da3f1fa120b3bc9965716f51210ceb8bc4703465859b8d78e9717e5731e24e1c73cc939e2e9a8733817e9c24e639b148bcb66a5b62ecf9c5e212ebd7293748f8a271ccb92f5f865eb8ce27d4178ebaebd1c056ad9a791b5aadd59699f08689465711104f
96c915895027138624dc2b0782de89cac2a420044eb9eb4033b10d0a4941d307b9562589ddebf0a9ec0bf8f05e38c4f22400a087a70417971f81da49dc4a2ba6cc76810e609f87a223973ef337b2c4b685a9c243da680ea7e37aab24e0426949097b49cfec9244bc12d5fa282c91e9f92596a1c45e17958895c324113dfa43d9
c3ff49ff81c057e387f29a7e43f2f15387005e0ffcf3d7e33eeb27627513527e2fa1dbbe0e5d9d9f944688e9f943b4e4eb97cf622f73df0709d48253c79a7e15470f23b63896f50bc6fa4f2c9167c4f54e57349c4e2c7945ea4e5e69cacf267e43e5111ccf164ec47de2db3a88eece7bab5d2bb6b79f1271c162cb365ea069c4
ce357524ea4e2cfac5a312a7b1afe3f875240b3f047988f799ce92f43813838d1dad9c5a76442a47658b6a5e78bf8eb104e644b642dfc47b2549f7e4808038bcc3d9cb89bbbd59f85327e1cd5bd490db4a86234bd13a90be7e2736a0e1cc593dd6222602f1d6284e08471c434de2712cb99626d5297496a9c743002a672dc9ec
e37064908e88916444ec730449d11adbcfa215d27d2a689dbf16f7dc8d80b6787c0921e98cb5f8c91a7e09389e70e2ae9a24592c90dcd5a925997cf273f1cd60122aa1169da73a4e28a76e1ba9d3c64de709cced924b69798a0fc42a1c1071ef7c50a57b885857e0299787e1a7739bd797f05e2667085955f81c6d79e22ee3dd
df59cfb79122f2b016327b6f08d4635fc389fac4f5e690eac899eb732d8893843888d1efbc8d2c25293a08a0266beecb64913bb5397e1a6911d2f5d3134e04e5cd11239a954c8f13b10b2bda992c6ed22491c3463109e09af0943710410d33277c7538611ede2132fded086709854cecfcebf28944eaee2939876250cbfa73cd
8841222426dec04ce57f18bc9df28a77c71efdc4c591f8c84fc9a7e4b3f265fddbf7783943b0e6bd9e4e191d0ee59f576a8a2d11da772123dfca7afce74e5d0b25edd913cc97226aa4eddb9c27e4e67a94c2127908a100ddf77e1d3b876f01d2673469272a51c1c045e4eb58f23c4b3417c7058416bca271e2cf259d971a5861
d71277c978f6f0a952d8d3d5dd380e9155dce0e07e251dc95cf0e9cd995f5bdf519123c5e8dc696bf09e3b91209cace7f2081d7e1bdc72e64847e180794ae8e091c4815dad8fbc3a9cc93832aaf72753823b3b1cd99245e38963a3485d7f1f1b84008d91370139e4209f6978953f08e2b874e6403a96c77a21244fc1d4ea6b89
cded326f7f2e9166a42f35927e1df0124924ec44b1a70ef849270e3dd7a93a216afe3c5933b13f113c9648e85ba937cdcf9239f6fc848e2063cb18584a83b16d0e52c1283938ddc38eb7e1212de9d24927b7ba75389ad2491c17846b38f63992849ca9c951604a6736689124749739d2ee1c3948e6b712c84b75ab9d70124954
b35116bcc764aae5470f99e65e7839eab9793d8ba33a5b0e370fbf0e26a9ea5e77e11296610d6ba4939e8e673dd96af7f95aa892581c57bcc9d73dad472ea249a4e549512c9212aafb2f6b2b5baa22a30e21cab394e9c26939ec6596dc9a2f135eb17a48b32081c71610e569c4bc38f269c5abecda4b04f62474e40eb9ea4e1c
4132ece504fc0051207e32cd468e391399c32f549d48e5e784237fdaebcb9fb12e70bacabff85348c1383ce26bc48b27316c2d471eb9f2fa48722634713c437fe44fc1c7090e85ee4f386dc4732a9da7b3f0fc0ea3cf834ae39e0ed3a6ffd517d3acf7391474e87ee22f49c44f1f585040585212080f929674e914767f278bf9
e9a94050e00270001042a0e2913f144edf5b1383ffa8687f90f2690e606c712f022d21ffdcc7f453f19110710a8dd26080fffa52020b00a020809161654548909c7dc67c9c212484ff17fb5ffdc9d4a6f6949a297b2b491feaffff320bc492572124fc1b7e5707f739bf938e5275bae993ff290bd34e25f79938ba64f0fff125
97de1ff9387038e51dc089c27c9fff6c3ff18d03b9790bcf08965f887fff053f03f53985944cbbbfc3b89dfe3ab587ffc0e3c0eff307d162733b3b7e1a7a35e63ffd0b277e527e90903de2beef94e254ad6b713b7ee43fe220ffc94c3b3b5e67e1ce4b7d3f8a3fd801ff9603921c5160869604b7ffa6fc7eebe9387e6e7abb8f
ac4732fe1246efcf7a93cf44397df49bfe61f82d165e68094f1f7426fc0487104058fbf730380700d221905af3f00e06ec057e403b73d6c7308e792109399fc123b858f2163f384b0a493b84bb9dab3a6fc4f0ff5dfe67e49d3dfffe24887c520b2dfc41a7bcf4747179f3ce9c715c04d24834ec3f7b24843a04210fcce4fea2
fe52cd4e3a9f3f83fc3ffb1f91cc31fe5ee343a8710fed7fb9ccfe61fdb758776c3805c87f8dfc9fffac8a7e221fda0fdcffce7076752383f2053f83f93ff284a0e8ffce7fff4c201d9d51cc290c7ff787ee0f2243f83980a53ffbdc7f10e8fee1cc388730ffea7fe33fc8730a0e01fdafee4899783b29e27f4bc40710d0ffe0
179050720ffce1dd1001014ffd276130860610e8c7f480202928007fe5077238a383987547fe08e61138290e21f898f427e50fc4ea8fd8f1bfcbf81f914f043f23fa87eefc3a1087c5383ff11fffc35ee70a43a0421face5f89fffcbb1343a87147e76321fcd5a5fcc596ffe9863f2e047fe687fea393fa0b41c028e107fe4d4
7fe80687f2171f8c1c28fc1c01f872514c7ef0a012007eebc1f950d47e87e1c14c529f95181414fd61fd12c3f53f0a4e4e647e147270707e80e61486384ffe90fc4ffd301b005141ffe61ffe21cc28383fd4ffc2dfb113f53d538ffe47ff687ec7fff05294a5072428a31087f27fff011239383a147c01fffd914510fc81c03f
ffc745070787021f48fdcfffe18380700fde818fd4fffe11ffffffe0e4314a52d0294a53fffb4720e01f99c03fffb8725294c4380700ffff19d1c0380750fffed14e014a7c53807fff64fffffff054fffffffffffffe0280ffcff877fffc5a199a289a3a4a5a69700b465b38d8e8f606162a79d9f939495c0c1c2c3c4c563767
7adaeafd0d1d2d3d4d5bdbebf909192737578797a707172b1a9b2b5b6b7092cbb64da5dc4939e17adb8e38efcf7ee1f837e3f97e5f91f9aefd3f597f5fdb1b97ee9b70c9fc6afe64febfbaff113897c4380f33c9cffbff7fe0ffc3ff8bff1ffe17fe4fd2ffe5ffcce0ede7e9375d4ffcfffa2bff4ce7ff57febffd9ffb7ff77f
ef1fb4ffe1ffc6bff949ffcfffa57ff5fe13a9ffdb57ff7fc27ff8fff35ffea2f53ffdfffcafffa3c9fffbfff81c3fff827fff0399fffc29c3fff87dbfff89ffa00011012188001d060c2bfd01fe03050609fe0b0d0e11131419fe1b1d1e2c2d31fe34ff0008052d31312d4116696a6b6e6c464f58fd030608fe0a14151ffe22
2c3233ff0108053c3e3f3c50ff0108055052535064fd0fff00020027342b41327160a414565f3f58fd0103050608fe0a11fe13171c1ffe2226fe282c323336ff0102003a403a5041ff0102094e544e6455fd0f1a1b34ff0004002c30412b32622880570c98524ffd01050608fe0b0d0e11fe141c1ffe222c323536ff0104003b
3f503a41ff0104004f53644e55fd0f1a1bff000b002d1e232d144f70ff010b003214371e197cff010b093c2d3246506342045b6cfe6e74fd0206090a0f14fe161dfe22272c2e3237ff000b0528231e32147053ff010b052d193223197cff010b054150284b2d77551454854efd0306090a0f151ffe2227282c3233ff00010928
2d28382386774304784b42fd0206090a141ffe22272b2c3234ff0101093f3c374732ff01010953504b5b46fd0fff0001001e38234819a385a078524ffd0608fe0c0e1418191c1f202227282c32ff01010037513c6132fd0d0fff000109283c1e461f7766864e566558fd020406090a141f2022272b2c3234ff010109415a4164
3dfd0fff000500233c2c37285e7a9257535056fd0608fe0a14151afe1c1f2022282c303236ff0105003c55455041fd0fff00060023371e5a3283197718274578202d527258fd01050608fe0a101113141f2122282c3237fc35ff0106003c5a37645afd0f18192027ff000700324b55281e9e2753a44b3ffd030608fe0a111314
1afe1c1f2022282c30323336ff0107004b646e4137fd0fff000500372f342928489e5752533f4f58fd0608fe0a0e1418191ffe22282c32ff010500463e433837fd070bfe0dff0105075a52574c4b08fd01050ffe131a1b26303536ff0005002e3928322848074e85534d4f56fd0608fe0a0e1418191ffe22282c32ff0105003d
__sfx__
fe282c3216d6701420060403e3501087712021184411c4712001223432280623001336c770141000404291631f16314c670fc770001000433065623c01320537090351f54517d67060400a021170611f87722032
ff0104033f700020001a1761057510d670f0713f300040002801328055280160f2403a060359413d330098770b4600e0211d47120012280622e01335c770102000404015041a1133d700054013e7111a45123033
87fd0fff1a5251f13406d670fc770006000441144701a5461ec6701420060403e35011877144611f877230422c8772e403324333f7000c000284121e446385021d801235571d1273d3613f7000c000370132d047
46456b5e004100003410113234121141105636165433d70005030088770a011140513e3611f00222412260422c003320333f70003000101260656232c77014100005502205374043d7703f300084203245423042
0b0d0e142d1762c105061563d710064400a0213e3311f87722062324133f70008420011553243315d77010400500529504061263d3400fc77000200504228412061262215702a700c415105551ed670303009877
2dff010d154713e312280623241335c77010200500506504241473d7703f3000d43028005241211e4721a06733122016743d700060403e35011877144511c47120012230322c003320333f7000d4303747533512
5d74fd06070052e9102d4333d7200fc770001000013155331a5043754031145071151fd670687708050144713e312268772806232c77010100040424134291053d7703f300040601a50401570284610f26018164
1efe222c088770b4600e001140513e3611e877220323e3422c8772e403324233e7333f700040601f5542e171109003d700054701187713c770003000441230342d4753a5322d455321650fd67064400a02118441
0608fe0a324333f70006000320631f13438d670fc770040009023015333c05324637030741655425d6702020060403e350144713e312270422c0133e3233f30001440234252d454234373102126174185263d320
050050501f877220422b062320233f700014403c076061263cc670fc7700020004042d4332d0340d4402c026181643d3303e3400a8770c070100211f002220423242336c77010200a05506105065753d7703f300
272c2f3132441288613a16709667132431dd670604014421184411f00222022260622f0133f70005000295460b11301d670fc77000200007101126284620d035249601b9000fd67064403e3600e0211e87722022
0508fe0a324233f70004050324753423415d603d7600fc77004700507123071101262a42739d303fd670602115041194611f002220222c0722f0133f7000f4202d0132d47533d770147005063011632e9103d700
0a11fe140f4013e7112304236c7700460074122d802061713c52414417045743ad67060403e3501a8771c47120012240422c4723001336c770006000063304622a055365611326434565384273d7000503008877
ff0006001e877230422a0623e3723101337c77010600042509134035173d7703f300040001e4461a113190671d63401104169413d710060403e37014471200122c0133342336c770102000433026170b1133d770
252c2e2f28071320263747227c101c1220f1573d33009021184411e877220622d01337c770103000063320340c2053d77028c77000400c0632800528063142312c56629502351763d33009050144613e30222022
32fd0fff32c77010400c4751f5253746707d670f4211640236c770043000013324752304214c710ae20111350c11518d6701420060403e37011877130513e3611f0022203228062320333f700070003c0052e562
3236ff000041000013385231751205c01056440a13708d6701030088770a4013e3211f00222412270422c01336c770041000013295740c512124003b8773e4373d720060403e3501141114471200122343228062
32ff0105010001a5330b1713c05705d0007565105553d70003420060403e77011877140413e7511f002220322806232413350333f30005000284041f5123c47204277092220f9403d33014041194712001226062
32690a83004041a1473c4253d7703f30007460105251f5411e440165300e115075643d33008050140413e3611f00222032280623001336c77014300d44602247284623d700054503e71135c77004000085705420
1f202228012533d1451a11538c670142006040094503e7701187714031184411d8772342226042290623e37231013364333f30008000015333316324156051342c9772e146049703d710060403e3500f0213e331
1f2022272c01333c7700400004461f1051a1421923501015171213bc6705030088770f4013e711188771b47120012260422c0033242336c770002000071280343c034225370c0353e9413d330098770b4600e021
5546628328062324233f70004000374041f5251fd670fc770002000462031633f013375300b2740d555125263d330098770e0211f0022243228062324233f70004000101650112410d670fc7700020000712d433
141618193d5323b1670c4743d330098770b4600e021184411d877220422c8772e4033242337c77010200c0630b525331263d77027c7700060000422d4041a126320373a02703a103d70005030088770a47011877
fe141dfe1d877230422c8772e4333f3000b44006176105463741437510242020523538d67064400a470144712243228062324133f3000a06001113234751f170119313d0403ac3038c6701420064403e7600f401
08fe0a0f230422c07232c770003000404135432952519c103e0573214716d6701420060403e3500f4013e321184613e712270422c8772e013364333f30002000015753946515106082773c477165753d70005030
080a0dfe11877144613e30222412260422c072320333f3000b0000156724525374102426701d201302400d67060403e3500f40114471200122c013330333f300010000b1261f1760654014035071150fd6706877
0d7f08610f0413e7511f0022203228062320333f300040001405037005144741be7701020094753d574111260f0161653117d67060403e37014041194713e312260422c013350333f3000405002625101631f116
ff0104001a16018d6706430098770b0700f02116877194611f877220422c0723242336c770040000003300033000317e77004000043337013374040943505215381450b5743d33008050144713e312270422c013
284b3163026043c4042e11621961249200cc67094500d8770f4233f31006000015043c8102e541155372d04432d6709470184333f71002000019103c4042e10614035319401fd670947026c7700400004043c034
070f111321a12375570fd67064400a4603e77014041194613e312270422c8772e01337c770046004412280262305522d6016564002603d330088770b4600e0211f87722062324233f7000d020061633d53333d67
060a141728c770046004071101553746222135242463f0673d330088770e0211f87722062324233f7000d0203c4172910506d67024100547011411284133f3000d44010546019103c470094351b51437d6702020
65fd02041f87722032274522c01334c7700400008022e5041e4040f0503c162080640fe6701420064400b8770e0013e321160413e7511d4713e322260422e0033242336c7700050090551512615567215370e460
06090a0f064403e3600f0211f877224322b062320233f300064401a155151263dd1037541261173d31004030090500f021184713e312274523e7623202337c770001009055241551a5672b4371650725d6702020
36ff000c144713e312264322c01334c77000700044200562320130f431055372d00516d67060403e37014041194713e3122687728062324233f7000e0003d0250113406d6707c77010700945506675101263d310
00100000000562e15502a510f6063b561026321d1273d700050300887714031184411e87724032280623e37231013364333f3000c00024126241262456123400172433d3103e3611e877220223e7333ff7700000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
25100000136331d6321b6311a6320e45015456134560e45524352243521f3521f35230352243521a3561835627052270501f0521f052204421a4460e4460e4461e2501925018256192562c3322e3422c3461d532
251000002613227142261461a53209252092560b2510c25236322363323233232342183510c352183521565033332333422e234245352e4322f4422c4362a4211425214256162561825118252182561a2521b252
250f000018200182001a2001b20000000363003630032300323000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
250e00002c3002e3002c3001d50000000000000000000000260002800026000235003c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
01101c1e18052180550000000000130551300500000000000c0550000000000000000f0551b005000000000024005240050000000000000000000000000000000e15515155111351013510002041750000000000
__music__
00 3c414628
02 557f0108
00 054b5055
04 32647d08
04 0f167f00
00 0b082346
00 3719376a
07 241a156d
02 3f7d0306
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

