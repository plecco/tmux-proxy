# Tmux proxy status

Enables displaying proxy status in tmux status bar.

### Usage

Add `#{proxy_status}` strings to existing `status-left/right` tmux option. Example:

    # in .tmux.conf
    set -g status-right #{proxy_status} | %a %h-%d %H:%M '

### Installation

Clone the repo:

    $ git clone https://github.com/jpstokes/tmux-proxy ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/proxy.tmux

Add script to enable / disable proxy in tmux:
  
Set proxy

    enable_proxy(){
      tmux setenv -g http_proxy proxy-ip-address
      tmux source-file ~/.tmux.conf  # reload tmux
    }
  
Unset proxy

    disable_proxy(){
      tmux setenv -gu http_proxy
      tmux source-file ~/.tmux.conf  # reload tmux
    }

### TODO

Update status without having to script proxy commands.
Create key binding to toggle proxy status.
