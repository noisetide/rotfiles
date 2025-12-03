{
  lib,
  stdenv,
  cmake,
  pkg-config,
  libsndfile,
  flac,
  libogg,
  libvorbis,
  libopus,
  libjack2,
  xorg,
  libxkbcommon,
  cairo,
  glib,
  freetype,
  pango,
  source,
}:

stdenv.mkDerivation (
  source
  // rec {

    buildInputs = [
      libsndfile
      flac
      libogg
      libvorbis
      libopus
      libjack2
      xorg.libX11
      xorg.libxcb
      xorg.libXau
      xorg.libXdmcp
      xorg.xcbutil
      xorg.xcbutilcursor
      xorg.xcbutilrenderutil
      xorg.xcbutilkeysyms
      xorg.xcbutilimage
      libxkbcommon
      cairo
      glib
      freetype
      pango
    ];

    nativeBuildInputs = [
      cmake
      pkg-config
    ];

    # build only LV2, disable VST3 / GUI
    cmakeFlags = [
      "-DPLUGIN_LV2=ON"
      "-DPLUGIN_VST3=OFF"
      "-DPLUGIN_AU=OFF"
      "-DPLUGIN_PUREDATA=OFF"
      "-DPLUGIN_VST2=OFF"
      "-DENABLE_TESTS=OFF"  # if tests need disabling, though sfizz uses PLUGIN_* not BUILD_* for this
    ];


    installPhase = ''
      runHook preInstall
      echo "PWD during installPhase: $PWD"
      ls
      ls plugins || true

      mkdir -p $out/lib/lv2
      cp -r sfizz.lv2 $out/lib/lv2/

      runHook postInstall
    '';



    meta = {
      description = "sfizz SFZ sampler — LV2 plugin only";
      license = lib.licenses.bsd2;
      platforms = [ "x86_64-linux" ];
    };
  }
)
