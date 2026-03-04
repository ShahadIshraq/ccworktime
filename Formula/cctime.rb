class Cctime < Formula
  desc "Calculate work time from Claude Code session logs"
  homepage "https://github.com/ShahadIshraq/cctime"
  version "0.0.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ShahadIshraq/cctime/releases/download/v#{version}/cctime-darwin-arm64.tar.gz"
      sha256 "REPLACE_WITH_ACTUAL_SHA256"
    else
      url "https://github.com/ShahadIshraq/cctime/releases/download/v#{version}/cctime-darwin-x64.tar.gz"
      sha256 "REPLACE_WITH_ACTUAL_SHA256"
    end
  end

  on_linux do
    url "https://github.com/ShahadIshraq/cctime/releases/download/v#{version}/cctime-linux-x64.tar.gz"
    sha256 "REPLACE_WITH_ACTUAL_SHA256"
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "cctime-darwin-arm64" => "cctime"
    elsif OS.mac?
      bin.install "cctime-darwin-x64" => "cctime"
    else
      bin.install "cctime-linux-x64" => "cctime"
    end
  end

  def caveats
    <<~EOS
      cctime reads session data from ~/.claude/
      Make sure Claude Code is installed: https://claude.ai/code
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/cctime --help")
    assert_match version.to_s, shell_output("#{bin}/cctime --version")
  end
end
