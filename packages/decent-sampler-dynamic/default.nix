{
  lib,
  stdenv,
  fetchzip,
  fetchurl,
  makeDesktopItem,
  copyDesktopItems,
  buildFHSEnv,
  alsa-lib,
  freetype,
  nghttp2,
  libX11,
  expat,
  # <- this comes from nvfetcher via your helper `w`
  source,
}:

let
  # Let nvfetcher drive name + version
  pname = source.pname or "decent-sampler-dynamic";
  version = source.version;

  icon = fetchurl {
    url = "https://www.decentsamples.com/wp-content/uploads/2018/09/cropped-Favicon_512x512.png";
    hash = "sha256-EXjaHrlXY0HU2EGTrActNbltIiqTLfdkFgP7FXoLzrM=";
  };

  decent-sampler = stdenv.mkDerivation {
    inherit pname version;

    # 👇 the only real change vs nixpkgs:
    # use nvfetcher-provided src instead of hard-coded fetchzip
    src = source.src;

    nativeBuildInputs = [ copyDesktopItems ];

    desktopItems = [
      (makeDesktopItem {
        type = "Application";
        name = "decent-sampler";
        desktopName = "Decent Sampler";
        comment = "DecentSampler player";
        icon = "decent-sampler";
        exec = "decent-sampler";
        categories = [
          "Audio"
          "AudioVideo"
        ];
      })
    ];

    installPhase = ''
      runHook preInstall

      install -Dm755 DecentSampler $out/bin/decent-sampler
      install -Dm755 DecentSampler.so -t $out/lib/vst
      install -d "$out/lib/vst3" && cp -r "DecentSampler.vst3" $out/lib/vst3
      install -Dm444 ${icon} $out/share/pixmaps/decent-sampler.png

      runHook postInstall
    '';
  };

in
buildFHSEnv {
  inherit (decent-sampler) pname version;

  targetPkgs = pkgs: [
    alsa-lib
    decent-sampler
    freetype
    nghttp2
    libX11
    expat
  ];

  runScript = "decent-sampler";

  extraInstallCommands = ''
    cp -r ${decent-sampler}/lib $out/lib
    cp -r ${decent-sampler}/share $out/share
  '';

  meta = with lib; {
    description = "Audio sample player (Decent Sampler, dynamic Linux build via nvfetcher)";
    longDescription = ''
      Decent Sampler is an audio sample player.
      Allowing you to play sample libraries in the DecentSampler format
      (files with extensions: dspreset and dslibrary).
    '';
    mainProgram = "decent-sampler";
    homepage = "https://www.decentsamples.com/product/decent-sampler-plugin/";
    license = licenses.unfree;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [
      adam248
      chewblacka
      kaptcha0
    ];
  };
}
