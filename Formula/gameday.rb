class Gameday < Formula
  desc "Terminal sports board: the game worth watching is at the top. Nine leagues, no account, one binary."
  homepage "https://github.com/WallyMagill/gameday"
  version "1.0.0-rc.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/WallyMagill/gameday/releases/download/v1.0.0-rc.2/gameday-aarch64-apple-darwin.tar.xz"
      sha256 "b738534eb5b47bc7d7ed700e8381f2a52c331dd88f982a809934c24d4a9ef6b2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/WallyMagill/gameday/releases/download/v1.0.0-rc.2/gameday-x86_64-apple-darwin.tar.xz"
      sha256 "737edb2e2bd6d9cc0b2982f62a058b13f59260bafa2b76fa729dc5b7928fcc20"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/WallyMagill/gameday/releases/download/v1.0.0-rc.2/gameday-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4b9b758302763081de06c14cae7049b891c96ca48c64913d91ef6e70985b0d78"
    end
    if Hardware::CPU.intel?
      url "https://github.com/WallyMagill/gameday/releases/download/v1.0.0-rc.2/gameday-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a9115bf2d58ef9c968ce6fb4c66bbf5131e5041d908fd7330061f7906d3c24d8"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "gameday"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gameday"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "gameday"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gameday"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
