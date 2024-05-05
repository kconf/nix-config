{ user, ... }:
{
  programs.git = {
    enable = true;

    userName = user.fullname;
    userEmail = user.email;

    extraConfig = {
      init = {
        defaultBranch = "main";
      };

      github = {
        user = user.github;
      };
    };

    ignores = [
      ".DS_Store"
      "*.un~"
      "*~"
      ".*.swp"
    ];

    lfs.enable = true;
    delta.enable = true;

    aliases = {
      a = "add";
      b = "branch -v";
      c = "commit -m";
      ca = "commit -am";
      ci = "commit";
      amend = "commit --amend";
      co = "checkout";
      d = "diff";
      dc = "diff --cached";
      last = "diff HEAD^";
      l = ''log --pretty=format:"%C(blue)%ad%Creset %C(yellow)%h%C(green)%d%Creset %C(blue)%s %C(magenta) [%an]%Creset"'';
      lg = "log --graph --date=short";
      la = ''log --pretty=format:"%h %cr %cn %Cgreen%s%Creset" --name-status'';
      ls = ''log --pretty=format:"%h %cr %cn %Cgreen%s%Creset"'';
      pl = "pull";
      ps = "push";
      ir = "!git reset $(git log --date=short --color | fzf-tmux -r 60% --ansi | awk '{ print $2 }')";
      r = "remote -v";
      s = "status";
      t = "tag -n";
      ignore = "!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      aliases = {
        clone = "repo clone";
        co = "pr checkout";
        w = "repo view -w";
      };
    };
  };
}
