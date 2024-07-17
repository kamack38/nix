{ config, ... }: {
  programs.gh.enable = true;

  programs.git = {
    delta = {
      enable = true;
      options = {
        plus-style = "syntax #012800";
        minus-style = "syntax #340001";
        syntax-theme = "OneHalfDark";
        navigate = true;
        line-numbers = true;
        side-by-side = true;
      };
    };

    enable = true;
    userName = config.var.git.name;
    userEmail = config.var.git.email;
    signing.key = config.var.git.signingkey;
    signing.signByDefault = true;

    aliases = {
      dtf = "!git --git-dir=$HOME/.dotfiles --work-tree=$HOME";
      alias = ''
        !git config --list | grep ^alias\. | cut -c 7- | grep -Ei --color "$1" "#"'';
      gconfig = "config --global";
      commits =
        "log --all --graph --pretty=format:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an> %C(yellow)(%G?)%Creset'";
      unstage = "restore --staged";
      uncommit = "reset --soft HEAD^";
      clean-remotes = "remote prune origin";
      repo-size = "count-objects -vH";
      s = "status -s";
      u = "add -u";
      b = "branch";
      ba = "branch -a";
      co = "checkout";
      cm = "!git cz && git push";
      cdf = "diff --cached";
      can = "commit --amend --no-edit";
      pon = "!git push -u origin $(git rev-parse --abbrev-ref HEAD)";
      pt = "push --tags";
      pf = "push --force";
      pl = "push --force-with-lease";
      pr = "pull --rebase";
      d-rem-tags = "!git push origin --delete $(git tag -l) ";
      dtag = ''!git tag -d "$1" && git push --delete origin "$1" "#"'';
      resign =
        "rebase --exec 'GIT_COMMITTER_DATE=\"$(git log -n 1 --format=%aD)\" git commit --amend --no-edit -n -S'";
    };

    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      color.ui = true;
      help.autocorrect = 1;
      merge.tool = "nvimdiff";
      push.followTags = true;
      format.pretty =
        "%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset";
      url = {
        # Github
        "git@github.com:" = {
          insteadOf = [ "gh:" ];
          pushInsteadOf = [ "github:" "git://github.com/" ];
        };
        "git://github.com/" = { insteadOf = [ "github:" ]; };

        # Gist
        "git@gist.github.com:" = {
          insteadOf = [ "gst:" ];
          pushInsteadOf = [ "gist:" "git://gist.github.com/" ];
        };
        "git://gist.github.com/" = { insteadOf = [ "gist:" ]; };

        # Gitlab
        "git@gitlab.com:" = {
          insteadOf = "gl:";
          pushInsteadOf = [ "gitlab:" "git://gitlab.com/" ];
        };
        "git://gitlab.com/" = { insteadOf = "gitlab:"; };

        # AUR
        "aur@aur.archlinux.org:" = {
          insteadOf = "aur:";
          pushInsteadOf = "git://aur@aur.archlinux.org";
        };
      };
    };
  };
}
