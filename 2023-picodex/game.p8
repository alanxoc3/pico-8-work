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
c0002e1186221ac2a8d2f8b3ffff8ff7ffff78fd0ae32cd47116bdf0fa3424f7ff93169fdc5cc9fd2f3fbcffd8ae6617777f01191cc393f3aef39bbd3fb9641e
b3a69716352b321797c131796997d34137d7d7f0933f3cbc8f24d442cf9076334dcbbfc35ec1ef13d0f1a824e46174f4331c7ef1795e9fe7e4d17a06989d87be
1fcb964669172a7224e0c972104d9c4de53fd893ba9f55d9375fabf0876eb288f1a8b9daf23e3f290f6ab8f9988f813a9895b7fde4423d97ca7158c232017732
2f37ed0db9974cc9420ecbf44c720e30e4eb29d746c49d92fc35c8d2ab3f465d398b563787fcecb7e8f5581e60254054be2a8cdafa05f8b2ba6190e8a26f88e4
e9676a5e5339c917402bac5e464778c0482ea290e59d91a59c4b49251e07465a1b3186def23745aa76c26edd83b69fecfccc3a9dd9298317cceb02d9e7405dfc
3e48095bbb4a39353f589830744ec864e9b3e6a5744ebaf2f7b954cff3402f27e80237979d5c6ec92a2419a0bea848cd2131e5830e2120fef1e8956c197199d5
e733e877415d43cf169f8494c94092a7c990667e186669fbe3ab88cbe93b17b03a623f3721ba2f2133dab7679974b11f4eb93fc973d16f0798ecee5fa1e4d2c9
2ad0c3cf2ef4a3c50b2e31a34927e4fbf0f9422e6c134e175d6e72959f0f4ebcec2eedbae09b2ebcfc21e6a7275b742572219593c941a29593ab07228be4b37e
c8e5d299a838a5f2f129834ea3b6e4463284b1e82fb52153deb62a1f530db873a80d394a3e7d9243399561bc83cb07bc1d11e0dae753174c88cf471e159cf929
8e2b39621ff17942be2f2d17fc1e7c5582a8cdedc96518832748f2219243f9a9e4f59fb54a832ae7e0c9f7e4b22f199fc9104e776c4302b6fc3e1afff3109fec
01f19ffafd6805e9ef4002ec3eea5659aee0c329f476dce076183ea8940ef7e61fcc1ee18b7b1f7e73985b236494dc793f0e7785777304e0d1369a3d614fb732
7ccdb35257d2cf2a33e94778b2c24ab29d8b3dab0bbef83cddc329cc0f8017bb865ef3f1c7cf15eb99cde722d98ecf94fe4e220431bdf27a4643bc3cf9a32fb7
3b7b91c34e87bdb77ccdefc3f137a33d3f70e24287fd68eb31d3d937d36ed6844e39e5bf45af7ffed30fb9b99e7a712fbee8c3b79fc42be7f5e9c21edc0f58b5
2c572c8cacea443b7c65fb10bd5de7f519359ccb2f93077f2f720e939e5f1e7655a096253fde552e93572d6f5ba717257d4e79f81c4c1e9c128d6a7f7c71b10f
340d5d7fc079a9c93639b51532837de8b4fdf7a99bcf5a0b567f2f406f6a7614a0d7b1f9f290fcebefa3c36f45fb48fe1475e8fec9af7b1f39fabc99ec195c6e
57e061f5ac117f80059d9ff2333e2f1b7ca122bbfe2b273fa7d5e31742baad41cbefc59c7ce17f9fef773f078866bfb9156977491ea7daa42bba1f85ddbe2a9b
2fe461ef1183b623fdda2993dad08d95831d8fd17533d88f9b2f8addb772d344d4832dd7320f2bab0034b9ec946de4b5497fe03698cceeec83de4a1beb4bb583
2b8b729597571c76adf261cb076eb572319a55b372b5c9cfd7e693aeb423dcdeb8dd297ce2e3c26cad1afc4b1f32b99fc0ece0d345ee9cc19cfc1ebd3793192f
c2e89d7215e465679e60aa4c42938401fd490ec321b7ee2dfb23838f2e85998fcae796ccfcdccb8f393f1b9f04f989f33c6e94f3723effe81fad6526d33b1f0e
be39ff3118bf9c1a21f1382f78ac2a9b0993f6f3e212215bbe0fbe99720e0e560b8ad32a3e5990359e7c81fe0746846959c7272401e125c2193cb0fba3b6f64e
596795aee532954c3128279e3a391cdd09bc3498c3b3c9ee44d4428e7ee316765221b89ab112a60407d43e18a774c1513d2fe8c2ea9fbf4e959385f25ec18369
7f48ba3df8ec1790f7508cf988b4830e935e86a9ca49e4e67b48e4e9d2c945e49cfc516fe4c544f6f6446eee43bb592e7a9562c964ad5a2987c28aca4ed52ae5
58389359751f79c6c49317ac0f164c2c675417039e02400799832a94401dbd179f57e4013b9656781e6b2e677c5ea6c9dc51b2c89eacabe2b68b96cc2b857282
34f2327482077450e834a8cd1d5a3419c95dbb947b40092007f3a244d5c39421a89a40a576810d6029db3b4a350fe4dbe4a254527ed497115b0ed44b4a2d1cc9
83b72cdd7a2e0bc7b9831e26c18dc9c9bdc9395d3e383f5f4c798919573e98662955c9ef90abb4a24d2b2144836a4e1835d7f21dedaedebee95ab45c694444bf
0bcbca6b931942af33d84c7b688ec99c5c9e702122ab0884b8beea72c21ef6e8d03ce50329444e3e78b00eb493256207a3c2c92a92da192cea51bcbd7c1ee639
1f788107221f5c42f118b9596939e57193a894954ce8d65e4708f5a077559fa174270c40a569e4562bb5402b1080484a4b2d238448594cec32fa2640f3643b68
42dc5a29b8ddf082deb279579032c801808647a7623ef1388b94ae6cc5f9194eec16bffcf59ab8e37732298b5af9d85d3cf6f690e0f57290944c29078ac1f312
cedb828c937ac648a3794b1dc3b02672e27f1083a82784cbb6b75e76ba23e496d2d9437e89a75f9396929329833efaf7b322177fd1d7d1e6643be01becf22167
b86d3e512392d414d6e4f99880e05cc9446e37bdf3e0f29a3221fb43c99f72908783082b3916e837bb80c2aef2a55a6a2924ecf5e7e1fe2175c3f4731e8fbc4b
dcfc7568979ff134a83e485983838f8c7292e072c13052e9217f04d5c7cb9d9a440969047ea980aa98cd895b1a6cbbac463ea84273ad9a6298114ee95cab374c
db7fab1edd2e9bd35b4bbe4bd945cfc7d34cb91fcfc57c0b7aa195463ea939d483f4d107479ec196bc4875c9a9f459c9efd5978b0eb40672d5da58eb549fdae6
8878050314e3377343dd31d48f3f21aa388d443eaa2e5fdeb0e18129a5f949f4ccb98b290359bbd4411b42836845073d9c4c528e4ec93f69401733fe147345f6
812e621ee39a42ae37fcc15a6b47462bb257341f3478a1c2c9ecec426a20247521777a507be9212477d4c09acabc0cdaa661cb62452f933b2917627b5a1ba672
35b89580446e15fc332876930309b401247003932e083ee8870d3b996c3e1170b295319e0c1929c25ae436ca1953c929dc2352dc3a3d1f0785a6eb9e16667e29
19e46586d8005807194216ac206d0da528049449c202d95a24c22d4494f6410d99bb349990e4c122617fd15ab4b183793ba909984258f42c8c2bc22d252fe803
d913a23699211142ac1276358996d6370c29243c0aa44317f6093972e4332e5cf571789ad92407839cc51112318947db4cdf7afaf9084eff1d311f37f158f4ef
59550f8ae7238057614ad992800988b32621e4904e94f37e81e89ebd888428c221b712cc77a31fbc588b6e690704472d27e6421842aab326318b2b85988f4ea3
073a287490472040bc4cc1019c72802bb87c9a9329e4b59501792917ee61273de23ce539b8b3b52c0fd483eb8552088065548218e425e04e2e2d415e8f124246
cf459478e8b15a757e528d2973214a8c3150090a97a3eaa239e92d54392779e819900135e4bb3195cc6995d0f69013f2cb0252b296b250994c6ecca466798854
b731c9c5aee5d3081e02cfe132983c493d847cb2c5423c68865737baac740d3b227a637215946f930e25b35edcc933481929563feab1187693977ee97e0120b4
077bd262b878f36939983ceb9d72f538682e2062254d80774a29063b567e98facd4c481ea123667ac1dcdc7c1e21304724837ae253517526ed022bec72755da3
64892086cb446eba1b4b5e11518248ea6077d24e1766852b249110836d7652c248b28821742c4a2e1fe65774bc46484e39a94a2ee77765420767eed1bad9061e
9399fc30524934db238cb41a0968f158743139d24f94721783121c62e23e07473cc6438052f290424e2462b446d82ca1a459acec99014eef4242e42694fda110
323722c26cb5aaa1fe2c9611287225707021707444128c5e6344b6139cb9b212426e94b2d0eab0a2ed73011e8fe872e254277bd64ce43c86dbec834a1c9187ec
12acef60a617722ba7097d943ffe2f5711d3ae178fcf29c9f1be8ae5e0970872d3197b92ec34adf8cdb31c03be49cfd922e72417832984c974929ca0daccf9e4
ca89c91f354a48783b3fa72be69a8347898239082e3f7231fa29a206e672a1472bfae4b6da0df148271c82faecb0a34276a53796f3107cece70f69543ee97a33
d8fcf63c93e1bc44c994872b179390cde4c54a1858d98888c98ab299a36737012fa4349a7c7c1e83be787d033b7b2184ce2dde4663dece9183d88f85be38a3f4
2c5215e072460e188b6ddf8f4479f83c90a7eaf2a1070200fb173717b7d6443b8088855fd1b854542f72810229b24a22b8fce6ba1ae046993817fc438ff22785
959cf128b7104cb2a5ec7e2385104c1ef1a9e7f7d85284d483cbee878f1862833975aa1723a4e49f510c21b447377587e46929abfa8bc19053aa3ded88e8420e
a216ba3fb01229b6c3cf356b072955d42229bc0eb821e46117803e39b92c1f8021755e2f753298a3cf7a52433104deadebcf6154dec5ac5d2eb45694529aecd6
438c481093c20ba5cfd54c73416af41616c190469831bd5efe682edfd2270848000ebd5394e462b021ecb2782a272e0adbec915e8585076739184f58d937b289
83c928b31e5349c99e025e314209857e897a90bc8a6d621c1ce4d925704d832ed44a1450694dbcf240880d178cdba517c2eab3c2448877463219cd93071e2d94
423d78c191324e9ffa0294a1ef74610f5e90c62e742ed31805ce84f114b327295712aa8b11d3e5c5d7555b617fa40b679e90041ef30f670ea3750696e37c7e93
87e7727e970bcfad048780c0828e78e0be31d8f26eaef4261715efcb7c84cb8b76701b4fe7236255782e0de448a3184137f3a17b4a5d120eef167a375ae4cfb5
4c58824097bc3d2ff5358e96fc39987ac71ceb1b99f411a601f7c1c24ea32ee2de4ce45e47d9e973d64e1f7a7e0db8f0667363b7513a9a773e268923b7115435
9dc3db4a077b57e04bc90cb8d5833f0c4e8cec89c908f3908b933d7873e95a98069a1d798a92da5793e4d6fde044794d1eacbbcfc06e579be97227009c3cb91c
b248a40c98acccc9c68716b0d5702807909a0c3bc879070a3e59e4e61e5d45d4422783d798b71b97d945cbb2692595fc09de7c5e736354c96a1e7a51421b4748
6d9be84aca4318ca9c7ced5f2a9425533b0f9412ea6d484369f1a32e27a19e879b2c9c87e4c675d17dea056190acfed95cd94a6e7a95e4b64417667f6b7e5d58
f62eb6bd1706cb740e2123bfbc142c17168bc9440d9e82d47d7dc83ea5ba7ef8ddfedcd093173a707ee66996b85c587e69e7027540494afae0560d3e1ff928da
e82865e4c53424f2044299cc3159bc9a5bee943cb8bc9a718929cc17a35e21293579c5ac1a5367d3949212c19c2cdcd5bc21235d807979f032b84d95d9ec0518
1d6cd92b8b6947218728bcd47a8494908f5284b432b8b9c578115a74402bca7efb1233c1a3e556467b376d09861d50a05b6c095c2a497980b87638d24a61c1ec
837ce2422e35d97da0539702420b48cc09d432e819210201cbb5c744953df5123ce5c1ac34e420e44a5b028c59f3b48febe33ff05ce0dc800259c8f9bc9ec79f
2c0729e7f328578f7cb6317fcb573c7880810e0f65d94cdfc9a8d0d3eee5ff713e52e4d6f3eaa31eaea2a70b4e4ebb973d8a39f67c8b9aa72e3f4de4401b4bf3
1183870e87907dd1e7312bcc122c43f360179361423e593e954c8ede5f328826b3228729137a30090aa09a864ef8a5375e399c2c8442f26ba0ded9979f042787
7b776eded584002e37bc98c34b2d5c9321915cb32d37c59412b24a2947445fc545947c3b793918468ef9c4040e09f5144c84be2a832b214212e9447315c229eb
3be8f670fbf984e9c15083b9d86651130cc9d5a57210a76b8827c1976c48a921d5f1994c423694015e7ab0f1676b4f6e2e16b92b7415398891ae943af22d4e28
d9d47185ec32492a1750db611f0c6e29144a316999b2c47401a8cb0019a53fd4ed0b0138f583802d541e3efd4683c95bcd8bcde7c746e9c11793839d26ab0774
840e68644c2a24e060ca2f5ec9b5f2113ae89b6b2262c45795e21b8798d7c209b29c73f3c899a0be61d1540d2994ed3be603cf567eea3a4259a64629e4fac157
124c023468f50c83b81162699a8df370b16551f33332376dbf17eb54e5e82ae07784e609dc2372e0552a27298a6bc0247a2376670f6748a5c00e73b280009d4c
52dba02936d89bcda2aa18c407be9858446e5fe285697a29fdd19852a3c937560a279f278d27ddbb3d8806a8a9040e1b10165a831a2074874c4388c924d65794
46695469e544922434b44db10f2c36d9d3997d65bda288863f42a489cf1edc7ac600ffff8ff7ffff78fd0aa42bc655fb90977e004fc138ea049f92ace818ff2c
76869c2a053843952272435be33e17bc18c967091f0dff2ceed983d9a3e9f4167e03ab329af22f76016e80472ed9a3787ec57fc14ceab188e4c78f0d9298a42a
be7e9176e8d90ab704d349d98357f5e07200247534e8d27e5e99d433e5882bf5049cccfefc7a526e3ab8217fe115018e35eaa9742347e409e8889e4cb217a7d9
e7d122a42e3ced5094a6adc9ab7876337b9acac29e2dddfddb9cc2295437b04e5a7f0f701ea39ef148cfc1456ef0c56fae340c2afbe19e0ad9a4fe8bcaafec29
b3517c15c542005ba3b4d1f41cede420b1596920c94a2520049a9fa1ccb5569400bdcb2c54f41542985aa3adf5b3bbe9b3aebd76b6232a9421e47a42528ab040
9c5efb79e374239c11405ea63087c37c801ef2610779798a7aa1841785ca2598d083cb009442122aab46474e2972112189bc61f2d27621dc4c45244faa0628b8
2172904db44220690f77224075e05eb64e496eef4126b6d97a214dd7203701652400213c55363d2881216517e4c66e0448396114e46d0682342d9bcea47e7742
490cf9591a7ceaa7f480cbbc6285885c014829bb8438c1b44240985625808775f1a142c902952031492e448349429394772d5a19c852c72ef18fc1801e22021e
902232e943720f255b6883f394f18fd8f05e9f3d3cff7cc15f828537f5a972f28c507ff369e8420ef4dffa2cf4ac379317f68b98223aa819f3a1435e10e483e5
758c2b81ffe135bc7df5c809d4f6e40255e89024f1e898bc39aad0e54a3b7c7e1a7294a7afe759613979d49f878e7227edec7229b840cecbbae8d778a1bc4e08
1eb0e07ef63a2bf09cad4400fe97fd4a19fc0eaec1f57c8bfbd8acc137c6723e8f9cc122f66cc9ca78e6368e5035707be846f446698f8144e48ad67da565cf36
2fe49c1287193d1d1dad8f42949f390f21227047195277f3307572f159fd2982293f522d1132287427e7e2c1a0ada197c5e714fd77b9b63f7e7c82723301ea21
90d2a029e419c3ec615ac984c457fc4034d9d39010bc3fcff1126921443b9b7613b96907e54109e0c27b7aa62e3269cd84f8b99941f45c3c90a387cf31eb76f1
58493458cbd4ac880d7f44523e2a6dc39a8f1fa293e4864f118f04296f3eb8d79cf6866ed742b898925c29da942611762d41cde74739e755c62f3ff6e4125fb4
d14c90863e822d650885735e89b026446e85b5541959a76aacdde51110c3772224961d2c4aad6984119ba2e92a62e046eb44a5b4149c43f5ab3f1dc288d5ac21
b988d8c2d9b5fd293f42a337e00559321aaf3746948c580249d943523218299b2fb420beb1daf5f22ecb4b31105172ae80c0b61d7b0e5f98d6db9a95633340f3
4d4ea154f34fbb0edecce38895b234bf4702f3fff9737e11f373ef0c89ff7bf8f58fede87640994222943c3ff1cbc37a84f733f890d5f178e8700eb0f57920b8
000b95a1c6d3f938487a182cf10cda86e4e652f3801746e0721519554cb41050cba4c3cb642e82c3cbefc59cc58b78378b79a53978d301da80d4d9ace26a8d29
9dc161e198bc589f4e134df8d0b29c36c8d2e702537b562e22fb91210a337610bd0775654c71c15270b836352cf720b7057ac3327dd6a4031724278e84217412
487a4398010988932984324d6ea5db1fc5ab5ed3cf463fb3cb92239452d99b22b64db5b040bfca14505543be4ba95a09329ad18baffdcce4ca2719cdca77221f
f60510001e70312e0f188378929463c7d52514a2d5d6c92384be9ce9e52d1d8fa47622cae8a3f250d74698416961d8f2212a01442d8578364c027eea66179072
c955da8027405e48cf93b09d38d48c78104812dce8ba4bfac6e09ffeb3f9592eaf88d42425a1072121144d699307cfd707fdc8e5528e46ee761b5cf96301fd21
e5211983a511401ec46be6f799aa44ab4b4ceaf4e29c74014d57a2501fa011f37411f789766ee7530221a4670929a3f3430912b3b39341e8c183f7723a175c94
cc8fcf4e88340ec7f01c93f3ffbb32ffff1e86df7ef8ffe2500021918743a3780d24012d2582ff723e27273889458411d6ae1dc1744358607020d1248479e5a9
5872339839bbf3602466840c3b2211753b59499bce84aa2e21727442f9392be532f60693eb95452708975c3be81231a5e833bbc1e7a14e8b0948cd20b8f0c6da
b0124b45bf2f7a203f7c10e002e5c89444699c7680486d1194700090250572924c0afb29259418cb6e24329707019c76d01674c1e4429b44481b24f98801a870
21a45408661bcc17c678254e1e4d2ba514f7d2a2941240837e43ae241141fb04cb54586169912ca245291767d8624d247a6b94152a52c221542e014842722390
6a886b1103aa9e332717b8c69f5c74cbde2924d521612504781055b89a0cc84020012bc5425294030b5b20b57a053950cdd021ac294a7890be983128b4b0122e
2920699480e6b084211121a0c04a1812007db546e4d27eb8fc442e9e7940f2722188e944c38319546b52da112a222134ab83e41621e57d58272b47021e901c4c
284385c469f10919e0769021090b5920eca1b412e02bb4806624090fafc1f1d8788898266105ee8288a787c96141dff8cdfff42ee7f1089e78f22c21bf3e4bff
9d83349d2ffc5c3e3f24e1f303f472d3723794ad2442a3d9f3997f1e399c06cfb22c9fd1fd3138bd4ecf2217bbe785e637d3be9497cb64394df473ed9eac3787
cf4ac3e9af3e214c6efc2927f4518e84f4b9e714c1e841449f4ed924a1fd3599fe1560e9ec62cfce1eb289872810f494e1e97e1e722beef300f25e5176c5123e
e4d95a091388384974077882cde7d0a3c3cfca199f42d8c1c52e63e7a0ba6c1e2c39b42225e602ed7ae2ce239370a459bc0f25a5426f9446db074abb893e0f37
4e1765f426c11707e9e4079a2963cba2c2c95ace4688950f25281d7dc5762ee4729592e3e434ba4aa8382fe4c74a88f9381157beec258728f665e55ebed0da5e
a961e1625868a930d25fd53a28347ac1836e87607ce661cbd43e24561247177cf1a83078908fec79b4487bf8324bbaf2d2fc232a17425e92229c3d1273f97990
5bd1cac996773d8b398bc27d4cd871bc5c423b9ac5e56eb5d33c9a4d9bd65e0cf41ce85218d2b434bb5e984c682ee11eafd572acc548ae6a08ae5a904d5e4779
9db64769227aec7e70c195872efb22dd5ca5be28949339da6dcab237c2cf0596e1a48e9af2e72f40b64c7e4993ea2997a2a47e9c8b293357167a40b5a54fe6b3
0d05b3221522a8795932e93f9887de098559fc82329693ae44a28659015ae9e6e89ca2d946b04a44a09842399b002597a607a7f914671d7c25263d2ca9211063
4e51e769363ff3340f24a0c0d9f4f593f18f4a52357a491e702cef92872494f13e48e3dd3e4d783efc11f076319121c332a069a01eafe49f8861e91fc319123c
363e38795ec17a0e18d2b723d02109349d1e8377026ebd7238879817098e95d5851fe0662e70cbc122294d0772d7ca98164ab8c6de25c7126eb5286d6254abbc
fcea9e7ed1b74dd9b372411783b3cbbb8e598faa87c529e4ec3e9c12554aa81afd25e42dc183388bc2cb742270dc7eb8f542de4a7ed46cfe5a4817976e176c84
a9dc1f9052549851b6bae0112d455f3a7c1e93c9bda3920106bda2bc7f5973e4d68355179c56c9421b3338e8e3bf59e513c5f2a30270633787c973d05c987ce6
e7cbb4a1b72593f3400e1f83906c4948fe7ccb17c2c4ad64c34ec99c5ade26943ae886e8d1783ba9c9349886d25e7254ddd8b1a2ba98bb9f881e72e225579bb4
fd31993ae8bb97fd1e8f833d98c31e404984140d4e7c2e9491b2e4b1e8cdc2e4b04c79c9c58848aeb50183a92dc779e946894c2b8e52bef8a37e49e41a4c19f6
ea85881dcc93e921502ecd461b7c79e90a9e4c97a142936eb3174c13588e663743099984aae550cd73605ccd719987ad760e74035e2539520ee46767448cc014
4c2de2f6d22d01e562beaac9bba947e483b57625fdac1ffc11b39872d226170c22e083072937c238b921124e6b0c9c67552f82d99307c9eb3e8c70652729b4ab
eb3a4c852c28ad94d1a7bd48c9767524528b5a258329c19d720ea2e3e931e8d22914c3456e90cead904232e9c1175e6408888070356b09b3000f8449678e3e38
03cf5637d604077b99e65f4d321bfffa772df9888eff6cf99df0525398bd3a4b7b6cf128c172f9285793f989f0c5e809f735787ed2e249d9845cd3a3b86acfe0
5130e9aa559eb25941fe889c408657d3d783888f963c58e4945f54503210936b3fc51a76a2204f58e4092ffcdcbc0fe4c1229bc9e51d851cc1127de17d5ea24a
d9eceeddbe8f5b4872b3ec4a984cb8832924e5188dfe994fcbacddb6b7cbf6762937c1bffb802f622e4b292f39637920f510ac4dd39b7c294b1894d1ec6972f5
c984177c9228026b397871497e5d389a4ccfab3f6deeb606fb132f071290c9808542cd4c9e4f77408a98f20eae03083db9a3cbb7ae9dfce9e7b199d20bb43794
111194e2315aa4a62ec98432b8826d6421622b0f297178e0c9276962959ced440ca830ba9ff55c8fefb07d4a5f7b71e8f46c21ac3b7e75b9465fa3565f58e420
639f323de771e4c76b74f5780ede9fed77a5214435f2cb7e6517a327c9b0c1e18c2972a11b565048a80467fb64bbed83f86827e844122ceec3e477e0349446c9
46dd682e5783989562c1b1982574318407422966be4b5f9f8c9ec59487290934ec83bebe322821e6db9421f2e07452ec25c3fa87cb03a8e3cbe5b24c6fa36e3e
8b3d079ad91187b374b0dc43cf92da6b119348cb6b67312907e8b148e633135c341776319b3e94e4158ceec2f5255f3b987c05dd7ed2c5de429842230999b398
0af88348d9ac94a52c403f94bc1f3584b84005ebed16dc48c596c68268349c6c95fe11312da419e056f9694bcf2d2a81f159ce8b83212277d329afee2439b3f4
cf76ff0ffc2cdf4a247424c3f82cbd9fdbf9f83e4242d9757e4248931980579380e7331fe7377be6ca3f9aa168f5c32bfdd1fdb31b5d98e583cf6ed9d22c37e2
__gff__
ff010500463e433837fd070bfe0dff0105075a52574c4b08fd01050ffe131a1b26303536ff0005002e3928322848074e85534d4f56fd0608fe0a0e1418191ffe22282c32ff0105003d48394137fd0bfe0dff010507515c4d554b51fd0105070ffe131a1b26303536ff000100462d30233c83233a7d815a3858fd01050608fe0e
11fe141618191dfe2226282cfe2e31323637ff0101005f46493c55fd0fff000200262928414171607f5978525ffd0608fe0a141c1ffe2226fe282c32ff010200494c4b6464fd0fff000100732d1414190a082c5a3a815d38fd010506090bfe0e11fe141618191dfe2226282d2e31323637ff0101008c462d2d32fd080a0f2cff
__map__
72895c3d0821f81ecfcdaef924581d7312c138f31da26f4e2227883873392796405d13f03f03a15d43887b341e390750590d84e7cfa49052ca6f9d4e5f82ef3b41bd9d1bdeac7baf9f85f57c84d6ebf18e1dd2a7e01d6824387e59ca367e448388909f8bce34e519c447e2a9d37dc3f093f14da01df3da21a7af116ba1245069
270ea12588e8fc0539c7b13f2fce1dbf14f7b90c8671f89ef73b729dfe3f48831606573e2124a1a3ea1c7125bc09bf293e9ace59cdaf272fc53983a79b69e34ee2ce327639b5bddd75c725fa712f9ba44a2eb613985fbc9676e5f89210a3bfc2b779debf7e13a8e638e39f3f1e65a932bcec2715d77f8dd2c47070b7e936f6a7
3cfb5a3f292439ede196f1b9e2495e08724ecde69cf5af1da1c4964fc9cace3dfbf1c3888e396d17ae3c9e734e39efa38ee5e383e62c75c496f102a36e93573c24d671cd4d38ed3acdcf93b7539498608fcdc2be904a4fcb92470bef7538b38e7ceb64d2ddc13b91ace696b8096d871c3b4ca39ebceb692962c1372efe47144e
741c71f97e7224f139071df5ab8bcc70e5c697bc9cc8822912967170222477c6e10399cd71f79f87701047727e1f82714389cf7f9449489bc1654e12f30f65f799cb492271b236759c62938732969e322913b66893753704d9b911bec82ef25d2c964e89c45f2785d7be67139b3af34e354e38714f38bc4e273e3a9e52c9eba9
b8a7704c8370912745c1dbabcf9d38922c8f4d78e79d80405bcd891157afa4e6e94cde3a48842ef11c51d5c009caaf9af7bbb138179c445945c71a7379e14ef8404b78e27e304f1fc1245974709dbaae2b4c771ea04484282cd539770b6f5f138aee65922dfc27c0fffff87fffff87dfa03538e2294c7f69dc07eda0fc25599f
8b851ff8e72ee57e7239dd7509d3f1dd01ede875d7448f531fb3a8759dad8e6d88484796b069dade14916cf59e2f7ec278f2f28ee4f4d3c59f7e0b24273193c702d7d5c1892faf625e1c3ef16e944f8e378f1497df5cbe843a7578e3ee4f78859a77f477938e6fdc5e14944ddf12c90489c4fc24921c84728937e0e13c9f8d3a
0bcf8e2733127897efbdfc3c75f3124912939e2daeaa870b6f2d78e349c4371ba4a989c7a128904b0cbd73177378247c5aecc9ea49d27d35f647122521b3be848964bc1ab893877448e1dd485e3768c89c35e340b12c8939894e1c7e1c22f304348a63138c79889f3272e92e82695c0488ec8714f09c543510d384fc3bafba37
75271d733a6744b22b9f67a4c4e921cf19359889b4d12f491f8c3245e7787da99e71f56f1acefbeac2398691ea27926e0e3f0e624a37109d4d2392227979849e116983b7255e4a67dc4923a4456d44ed5f8fd041677932cae2dea24219d71788e068cb0b371af1d2e2fcae63c49c38e799273c5d350e6708bf4e09cc73629179
6cd4b6c5d9f38bc425d7ae526e91f144e399725ebf0cbd719c4fa82f1d75d7a380ad53134f235b55bab2d33e10d128cae22209f2d922b12a04e270c49b8560f05bd13958592420079cf5a019d8868524a0e983dcab12c4eef5f854f605fc782f1c627912005053d3105e5c7e0769277128ae9b31da0439827e1e888e5cfbccde
cb12da16a7290f29a03a9f8deaac938109a52425ed273fb24912f04b57e8a0b247c7e2965a8711785e5622570c9044f7e90f670ffd27fe07015f8e1fca69f90fcbc54e1c01783ff3cf5f94fbac9d09d44d49f8be876ef83976767e511a23a7e50ed393ae5f3d88be4f7c1c2732094f1e69f8551c3c8ed8e25bd42f1be93cb245
9f13d5395cd27138b1e517a93a79a72b3c95f90f9444733c593b11f78b6cea23bb39eead74aedade7c49c7058b2cd97a81c4e2671aba89d49c59f58b46254f635fc7f0ea48167e08f311ef339d25e87027071a3b5b38b4ec88548f0b16d4bc717f1d6209cc896c85bf88f64a93efc90100717987b39713777ab3f0a64fc39ab7
a921b6950c4697a2f5217cfc4e6e470e62c9eeb11130178eb142704238e21a6f138965ccb136a94ba4b54e3a1801533a6e4f271b83248474448b22276398224e88d6de7d10ae93e95344edf8b7bee46c20b6787c090f4c65afc648d3f049c4f3871574d122c96486e6ad492ccbe7939f8e6b00b0aa845f939d271453b70dd4e9
e326f384e676c925b4bcc507e2150e0838f7be2862bdc4242bf014cbc3f0d3b9cdebcbf82f1333842caafc0e36bcf11771eeeface7dbc8917a580b193db3846a31afe1c4fd627af34875644cf5b996c449c21c4468f7de49a584a527211404cd7dd96c922776a72fc34d223a5eba6269c09cb9a2247352a991e276216d7b5325
8dd244923868c6213c135e1286e20821a664ef8ea70c23dbc4265fbda10e1c261533a3f3afca2513abb8a4e61d89432fe9cf36210488909b7b0133a5fc22f277ca29df1c7bf7131647e3213f269f92cfc997f76fdde0e50ec39af6793864743b967d5daa28b44769dc848f7f29ebf39d39742c97b7644f325c89aa93b76e709f
9399ea530849e422840377ddf874ee1dbc07499cd1a49ca94707011793ad63c8f12cd05f1c16105af289c78b3c96765c6961875c49df25e3dbc2a54b634f5774e03a4557738381f894772573c3a736657d6f7d46448f17a371a5afc278ee448272b39fc82075f86f71cb99211f8601e52ba38247120576b63ef0ea7324e0caab
dc9d4e08ecec736649178e258e8d2175fc7c6e10023644dc04e790827da5e254fc238ae1d39900ea5b1de884913f0753a9ae2737b4c9bdfcba459a90bcd649f877c0492493b112c69c3be1249c38f75ea4e885abf8f164cec4fc44f25923a16ea4df373e48e7dbf21238818f2c61612a0ec5b4394b04a0e4e3770e3adf8484b7
a749249edee9d4e26b4924705e11ace3d8e64a1272a7254581299cd9a24491d25ce74bb870e5239adc4b212dd6ae75c0492552cd445af31d92ab951c3e679979e0e7aae5e4f62e8ce96c38dc3efc389aa7a979df844a598435ae924e7a399cf765abdfe56aa24960715ef3275cf6b51cba892693952544b2484aabecbdacad6e
a88a8c38872ace53a709a4e7b1965b7268bc4d7ac5e922cc82071c584395a712f0e3c9a716afb3692c13d891d3903ae7a9387104cbb39413f0014481f8cb351a38e44e670cbd527523979e108dff6baf2e7ec4b9c2eb2affe14d2304e0f389af122c9cc5b0b51c7ae7cbe921c898d1c4f10dff913f071c243a17b93ce1b711cc
aa769fcbe1cf183fff8717f380e27e13f1891296753a451febeb0a080b0a424101fe3a1f1a913f144edf5b13e7e50eb6d4a0287001380008215c0f0f13f1350718e25e045a75b3072121fe43c6a767fb3220e2155ba4c101c323d03a4c7f453ff9ca8a912138fc39cf93842493b7e5666387148082d028082024bcc3b5ffc139
27b45268b17b2b49c394f5bff727c9fe41b8922672124fc1b7e572ce127e4abfffc18dd9f974d34def339974c9e12324441cf5bdedca7fe52157b4e637ebca3b811b873f244e67e0ee24bef0ffc9c308747f7dcbe05e7844b2fc43a87ec8b0ffc6341ff9e5172eeff0fc2277f8ead61cbf211e0f0fc0fd4e61ffa634399dc76f
c74f46bcc684a892b901c78877f9829ffb67dd729c4a95655ee0203a14f3ca4fd21207bffb93b399f87393fb203ff25483f79dbe0421c516086968fe2041ff9487ef7e4fc21ffd77e5f873f49c6fce6dc667d623997f0922fbf7e1721cc7e1f8c6ff987e0945979a0253c8738df8090e2080b1f7ee60700e01a44320b5dfe01c
0bd00afc8076bdd3a8471c90849c5fe091dc2c790b1f9c2585249d424dc715c3a6fecff5e7e67e474f3fff89221f1482cbbf1069ef3d1d1c5e7bf3a73c5409a49069d07c75649087408421f99c9fd45fca5f3539ea7cfc227fe43ffb1f91cc31fa4399eb88750e21fdb8e9bfb89fcc3fbc3bb4700b90fed3b75fcc3ff6b702ca
a7e221fdaf484fdcff8e0ee2f324e0fc81fda767f27f81283ffffc100fd61cc290c7fff021fb94a0fd01cc0529fffc0b4fe21d1d9cd1c4388730fffa7f47f90e6141c03fb71d2fc7670bd9f04fc5bb95a40e21a1ffc02f20a0e41ff9c3ba2002029fe9d10ec2610c0c21d18fe90040525000fe8f28ee471470730ea8ffc11cc2
270521c43f132744a3f287e27547fe14ff2fe27e47c01f99fd43ff1421f14e0ffc47fff3272a43a0421face9fffd9a4d0ea1c51f9d8c87f35697f3165bff813b863f2e047fe22c3ff51c9fd04a0e0147083ff26fc47fe80687f2171f8c1c28fc1c01f87354531fbc2804801e9daf07e509a8fd01ee2b8294fca8c0a0a78750ff
6c3f589f43a3991f851c9c1c1fa03985218e13ffa43f13ff4c06c014507ff987ff88730a0e0ff4ffc2dfb1fdaf8dffc8fffff884a52941c90a28c43fffb2891c9c1d0a3e00fffec8a2887e40e01fffe3a28383c3810ffff20380700fde81fffd93ffffffc1c86294a5a05294a7fff68e41c03f33807fff70e4a52988700e01ff
fe33a380700ea1fffda29c0294f8a700fffec9ffffffe0a9fffffffffffffc0500ffcff877fffc5a1a0a290a3a4a5a69700b4b9b38d8e8f6e7c6fa79d9f949596c0c1c2c3c4c5897677adaeafd0d1d2d3d4d5bdbebf9192937d6c78797a7e6d7fb1b0b2b5b6b7092cbb64da5dc4939e17adb8e38efcf7ee1f837e3f97e5f91f9
aefd3f597f5fdb1b97ee9b70c9fc6afe64febfbaff113897c4380f33c9cffbff7fe0ffc3ff8bff1ffe17fe4fd2ffe5ffcce0ede7e9375d4ffcfffa2bff4ce7ff57febffd9ffb7ff77fef1fb4ffe1ffc6bff949ffcfffa57ff5fe13a9ffdb57ff7fc27ff8fff35ffea2f53ffdfffcafffa3c9fffbfff81c3fff827fff0399fffc
29c3fff87dbfff89ffa00011012188001d060c2bfd01fe03050609fe0b0d0e11131419fe1b1d1e2c2d31fe34ff0008052d31312d4116696a6b6e6c464f58fd030608fe0a14151ffe222c3233ff0108053c3e3f3c50ff0108055052535064fd0fff00020027342b41327160a414565f3f58fd0103050608fe0a11fe13171c1ffe
2226fe282c323336ff0102003a403a5041ff0102094e544e6455fd0f1a1b34ff0004002c30412b32622880570c98524ffd01050608fe0b0d0e11fe141c1ffe222c323536ff0104003b3f503a41ff0104004f53644e55fd0f1a1bff000b002d1e232d144f70ff010b003214371e197cff010b093c2d3246506342045b6cfe6e74
fd0206090a0f14fe161dfe22272c2e3237ff000b0528231e32147053ff010b052d193223197cff010b054150284b2d77551454854efd0306090a0f151ffe2227282c3233ff000109282d28382386774304784b42fd0206090a141ffe22272b2c3234ff0101093f3c374732ff01010953504b5b46fd0fff0001001e38234819a3
85a078524ffd0608fe0c0e1418191c1f202227282c32ff01010037513c6132fd0d0fff000109283c1e461f7766864e566558fd020406090a141f2022272b2c3234ff010109415a41643dfd0fff000500233c2c37285e7a9257535056fd0608fe0a14151afe1c1f2022282c303236ff0105003c55455041fd0fff00060023371e
5a3283197718274578202d527258fd01050608fe0a101113141f2122282c3237fc35ff0106003c5a37645afd0f18192027ff000700324b55281e9e2753a44b3ffd030608fe0a1113141afe1c1f2022282c30323336ff0107004b646e4137fd0fff000500372f342928489e5752533f4f58fd0608fe0a0e1418191ffe22282c32
__sfx__
237a51130040406163335043d7703f300040003202330433320161e2271d1153fc6701420060403e37010877140611f002224322806232423368670fe77010200000512174151053d7703f300030002800523034
1c1ffe2205a71394363f0353d70005030088770a0013e31114041190611f00222412270422c003320333f70003000015463c4753c0213d7703f30002000370342d063320063754016575195353d3300805014431
131a1b23268772806232c7701010000552e1051f1053d7701ec770002000042320421a14222d70080530c42718e67064403e7500d070144611f002220422c072324233f70004000015040115532c670142011877
0037322d36c77010200305515575061343d7703f3000c000190210f055291713d70005030088770a4013e3211d4713e712280623e3723101337c770106000042230712914721461106163b56534d671cc7701060
05324b2338d303d7703f3000300006105324122340113c202713539c6701420060403e350120211a8771c4712001223032280623001336c770141000005241342d0133f700030001a9101053301d670fc7700040
fd03060928034055561e5662e166101342ad67030300905014877164713e3122c01333c7701040054041a113374253f70008420105460113424d67084703f300044202804223034241163a9100e260131051b175
07375f733e7500d070144211f877220422c013334233f70004420101340112638d670fc77004600704210126140712f0513c51724c000fd6701030088770a4013e3211b0611f00222412260623001336c7701460
1d8f0c58234623f7000d430101760266237c67054703f300020003242537055015370940718534125753d3303e3400a0211f877220323e3422c0133f70002000011260654610d670fc77000200c055015040f042
090a14180c56534d67060403e7500d070100211a8771c0713e31226877280623e372310133587737c77010200c4750b1761e00500e67014200f4013e7113f3000600019412065621f157274621b1171c5743d330
4e5865fd190713e3122c01337c7701030000133c475061473d7703f3000144034404370633a822375100e1350b5263d31004030088770a0211f87722432280623287734c770040009412155620b5123750314036
5ffd0fff04030088770a4713e312284522c01334c7701400090632e134241633d7703f3000400001562374620656009062241450cd6706877080503e3600e001144712001228013350333f700040501a13410134
141efe22004200000510113190421c2573cd403dd11384653d33008021150411947120012240322c47232c77014200044629554324043d7703f300040001e404241422d460161260c655006743d330098770c070
3c6e82fd244322c4723101335c77010200a0131f923065250de670d4703f3000f4201e4121e0052415235547076773d33014421184411d47120012240622e47232c770147005462324621f5173f7000f4203c404
0105060801420088770a4701187713412280333f3000d43023462202341e06705121331240f1573d330088770a0513e3611f00222022280622f003320333f3000c0003c0032d0521a1371dc110c1271d14335d67
734b32fd3e35011877140713e712280522c8772e403324333f7000c000155440651433d670fc77000200007129155324413cd61075040013518e6703030088770e0211f0022206232413350333f7000400037810
1dfe20220fc7700030000421e013245332f43203265244743ad670644014041190713e3122c462324333f700060003c0130696010d670f0423f300080603c042101423c821160662d546214272ed67064400a021
003c506e244222c0722f0133f700080601f575155333d5343d77015031210333f30007000320131f512280211fa500560516164121453d70005030088770e4013e7111a8771c47120012260422c01336c7701430
222327282d0133d7703f3000300032047354352342011e2009154361443d700060403e3501187714471200122343228062320333f30003000324460f16423011014533e37337d6705030088770a401130211f002
1f2022262c01336c770040000055374541e0633a524016341d1051bd670141005030088770f4013e321188771b47120012260422c0133342336c77004200004201575230632f8203ed402447408e670602118441
0100fa052c0133f70005000011553816315d670fc77004300d00515575190710903507074125340dd67060400a021188771c47120012260422c003320333f7000746029910381422dc67014200b877134233f300
0a0f14fe050132915003e003a46718155121433d70005030084400b8770f4013e32116041194613e71225032284422c8772e4033203337c770004000404374173c0262a524061663e376281240ee670303008877
fe0b0d0e164712001228062324133f30001000295751015528c411650012535144533d720060403e77011877130413e7511f002220322806230013350333f300040001e0420616306116371601617718e6706440
04001e2d1447120012270422c01335c77010200043301575155753d7703f300040002d4143c4733243707c500e5641b11525d67064403e3701447120012270422c01335c7701020000051c504041053d7703f300
fe0a0f11374250611603667274573c1600fd67064403e7500d07014041194613e312280623e37231013354333f700040603c4541551724d670f4323f3000c0002846201155241133615334d1002e670142006040
09fe0d0f3e32116041194613e712280623e37237c7700450090342e10529533035370382220c20161473d330090500f0211f012270422c01333c77000500c404324121f5750e4051666308053072433d70005030
5ffd010511877144613e712280622e0133f30006000015153944615541032733a117381353d70005030088770a47011877140411d87723432280623e3723203337c7700010004041f5431d525209403e1633f135
524ffd06060403e3500f4013e3211d8772001223032280622e01336c7700450004043d12615533038223c50405611041043d330088770a470110211f002220623241336c770040000454245752e1340902116534
55503c5f3e3400a4603e770188771b47120012260422c01336c7700020000210a433101210fd513f700044401f5670f5052457022135174353d330088770e021184411f87722032280623242336c77000200a810
2227282c225603f140211550c0453d330074403e7500e470140313e7411d4713e312280622e013350333f30001000300033000330c313f3000100037433324330154017d2012147185540fd67060400a0211f877
0100413c32c7701020008100116301176225061c226042603d7400b4603e77035c77020300040401163022761942537562081173d7400f04137c77030100040402263011762012116507086753d7400f0323f300
3c7d3773061420b50323d02226373b5743d330090500d8770f021184411d87722432280623e372324333f3000d02023042245121a1160d2350d9000cc67060403e7500d070144713e3122c01335c770146004034
4377fd023d7300f401130423f3000d0201e0051a5332d01616922285733cd67060403e370144713e3122c01335c77014600406333546101343d310034200f4011304233c77004600900529504022630f44017555
7d61770e040300a021174713e312264322b062320233f300010002027601171015700a0672c0400cd703d70005030094503e3701087714031188771b4611f877240322807230013350333f3000a4401a52524525
7165fd020d4263d31004030098770c470144713e312274522c01334c7700030090551a52524567036371903632d6702020064400a470140411f877224322b8772d013344333f300024401a1261a1553d55237135
5f5064fd04030090500f0211f8772203227062320233f3000e000290042d013324701742437562101353d330088770e021184411f877220323e3422c01335c77010700046314504061343d7303f7000e4401b930
37ffff13020333f3000c0002a1761a9101ae70215571d8102746534d6701420060403e32116041190713e322260422c8772e4033203337c77000600002624126241261d41201c3138c67028771c0713e31224877
191987641005015460055602e0700a4503f5310745104411010540a246258601f552344121d0252705432442021720b1273c055012473614735133371353915320c110d55105255081333c0163d0262900311573
3f5060663d1151a0652704623465295010b5632f1532c4243114206d2024472071360c0172d4663804418514091251103113525120032c057205260f171191760f4023101403156384432b161144262a07618474
6a4c442a00157271043c506019200716531406096073f5673b1663746412543086220e1743b840260643e921084720507302037095273755523546002611447635413224231f417305553c93003205175752bd50
00100000195652d0411e91014a7015e600f21101d303b436090753312202232034570f2510362506c2111a1110a31172000000000000000000000000000000000000000000000000000000000000000000000000
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
011400002b447111361a14021136241421f136301421a136272421f237202421a2371e240192372c2462e7322624627732152462373236342323321834209330323422d3322e2422a23620242222312424727232
011400002f342153361a342264361134232436192460c2322c246112321a4422d43228446254311e2421a132242421f136233422133624342203363724726232292471f2321f440204321f442214362244221432
011400001f342213372b3421c3361d2423433628442354302b4423843220042211362404226136305421f536295421a5361d1461913223146221321a3421c331163401733129342293361414729232201472d236
01140000151401d03721142280362b2421f0371e2461f0371e446185321d5462543212447112321444715437221421e2302f242302321b5422123022542202322f042302362f0462b2322324230036234471c430
01140000214421f4361c4471f4371a0462633221342140311f34025036151421313718142171312d1423813620447274302444618432222401e7371e2471b7321e7421f2361d1471f13020142221311c04022031
011400002404026031172420c231232421b232225421c5313a0401a336270460d336211461c230180421a13615142141311b1422873611346241371334222136311400d0360d1401a036212420e0361844705437
011400002234016230293461d230122401223218240191361924717430242401f43624246274321b24618432294422c430154401f2371d2471c2372e246252301a14018137183400d237193421d2361e44719437
01140000294422543728140305320e2400f4321814613430351401b2302f142212373b4402c3322f447203320f447294320c4462f43219346133312c4401d231362471a137294401e43035247251361d2402d137
01140000241461f1301f34023230293402423022140243303c2462123031140234302b142264301c1402b1361c142244362e347343313a3461f4303b3462c33226347393322e3401f13639440394301524217236
011400003224737330271471a2322e24215330284462113023442103362e4421a3361f14729136217472b73618122181150f115031000c1150010013115132000000000000000000000000000000000000000000
__music__
00 00050928
00 2d233728
01 04437f57
06 5b157d02
00 0406090a
00 14151f20
00 22272c32
01 7f010509
00 4b50465a
04 4b7a7d0f
01 7f000805
00 2d32371e
00 4b166f5e
02 6c7e6e68
01 7d030609
00 0a14151f
01 7e222c32
02 337f0108
00 053c4146
04 28557f01
00 08054b50
08 5532647d
08 080f167f
00 000b0823
00 46371937
0e 6a241a15
04 6d3f7d03
04 06087e0a
02 147e161c
02 1f7e2228
08 2c32337f
00 010b083c
00 5f501e50
05 7d0f7f00
00 0b053c37
00 322d281d
08 6e636d15
00 6c745b4f
02 5d7d0609
04 0a147e16
02 1f7e222c
08 2e32377f
00 010b0546
00 413c5a5a
01 7d02040f
04 1e277f00
00 07000a37
00 195f2d1a
01 244b1c58
02 3f7d0608
01 7e0a141b
00 1f20222c
08 3032337f
00 01070023
00 50327846
05 7d0f7f00
00 0100282d
08 235a2824
01 1e7a1057
04 3f587d06
02 087e0c14
00 18191f20
00 2227282c
02 327f0101

