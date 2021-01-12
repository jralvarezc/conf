{ config, lib, pkgs, ... }:

{

  programs.broot = {
    enable = true;
    enableZshIntegration = true;
    verbs = [
      {
        invocation = "edit";
        key = "enter";
        shortcut = "e";
        execution = "$EDITOR {file}";
        leave_broot = false;
      }
      {
        invocation = "preview_text";
        key = "enter";
        shortcut = "bat";
        execution = "bat {file}";
        leave_broot = false;
      }
    ];
  };

}
