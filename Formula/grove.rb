class Grove < Formula
  desc "Zero-friction worktree management for developers"
  homepage "https://github.com/LeahArmstrong/grove-cli"
  url "https://github.com/LeahArmstrong/grove-cli/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "09de277857a1f71c6ac226ac003f298029ce60ca238c0f7cecd507624214d5c4"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/LeahArmstrong/grove-cli/internal/version.Version=#{version}
      -X github.com/LeahArmstrong/grove-cli/internal/version.Commit=HEAD
      -X github.com/LeahArmstrong/grove-cli/internal/version.BuildDate=#{time.iso8601}
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/grove"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/grove version")
  end

  def caveats
    <<~EOS
      To enable grove, add this to your shell configuration:

      For zsh (~/.zshrc):
        eval "$(grove install zsh)"

      For bash (~/.bashrc):
        eval "$(grove install bash)"

      Then reload your shell:
        source ~/.zshrc  # or ~/.bashrc
    EOS
  end
end
