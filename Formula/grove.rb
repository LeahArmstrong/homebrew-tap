class Grove < Formula
  desc "Zero-friction worktree management for developers"
  homepage "https://github.com/LeahArmstrong/grove-cli"
  url "https://github.com/LeahArmstrong/grove-cli/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "4609f10b2ad1446b92d1444c50a479a787705a46fa8d3b6c2ca0f065a63758ea"
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
