Swift_game1
===========

キャラを集め、ブロック崩しでボスを倒すことで音楽を集めるゲーム

#説明
画面下にボタンが5つ並んでいます。
左から順に

1.ゲームをスタートできる画面
2.ガチャをできる画面
3.集めたキャラクターを見て、ゲーム中のキャラクターをセットできる画面
4.ステータス画面
5.集めた曲を見て、ゲーム中の音楽にセットできる画面

となっています

基本の流れは

2の画面でガチャをします
手に入れたキャラを3の画面でセットします
1の画面からゲームをスタートします
ゲームのボスを倒すと20%の確率で曲がドロップします
5の画面で手に入れた曲を確認できます
(気に入った曲をゲーム中の音楽にセットすることも可能です)

となります。

ゲームのシステムはブロック崩しです。
ゲーム画面のどこかに渦巻きが出てくるのでそれに入ると次のステージにワープします。
またゲーム中に確率で出てくるCDを取るとボス戦に進みます。

#素材説明
肖像権と著作権の問題上キャラ画像と音楽のファイルを削除しております。

キャラ画像は101~699.jpgです。
AppDelegate.swift中のMAX[]の値を書き換えることで使える幅が変わります。
現在はlet MAX = [0,8,8,9,9,2,1]となっています。
これは101~108,201~208,301~309,401~409,501~502,601が使うということです

音楽とボスは現在は4つである。
音楽はmusic1.mp3〜music4.mp3というファイルで指定する。
またその音楽のアルバムアートワークをmusic1.jpg,music2.jpgというように音楽と対応させて入れておく。
ボスはBossSceneのテクスチャに適当な画像を指定すれば良い。
具体的には89~97行目の下記の部分である
    let bossTexture = SKTexture(imageNamed: "music1.jpg")
    let boss1Texture = SKTexture(imageNamed: "triangle.png")
    let boss2Texture = SKTexture(imageNamed: "rect.png")
    let boss3Texture = SKTexture(imageNamed: "radius.png")
    let boss4Texture = SKTexture(imageNamed: "main.png")
    let boss5Texture = SKTexture(imageNamed: "boss5.png")
    let boss6Texture = SKTexture(imageNamed: "boss6.png")
    let boss4_1Texture = SKTexture(imageNamed: "boss4_1.png")
    let boss4_2Texture = SKTexture(imageNamed: "boss4_2.png")

さらに
c.mp4という名前で動画を入れる。オープニングの映像になる
title.pngという名前でタイトル画像を入れる。
