# Print hilighted messages & private messages to window named "hilight"
# for irssi 0.7.99 by Timo Sirainen
use Irssi;
use vars qw($VERSION %IRSSI); 
$VERSION = "0.01";
%IRSSI = (
    authors	=> "Timo \'cras\' Sirainen",
    contact	=> "tss\@iki.fi", 
    name	=> "hilightwin",
    description	=> "Print hilighted messages & private messages to window named \"hilight\"",
    license	=> "Public Domain",
    url		=> "http://irssi.org/",
    changed	=> "2002-03-04T22:47+0100"
);

sub sig_printtext {
  my ($dest, $text, $stripped) = @_;

  if (($dest->{level} & (MSGLEVEL_HILIGHT|MSGLEVEL_MSGS)) &&
      ($dest->{level} & MSGLEVEL_NOHILIGHT) == 0) {
    $window = Irssi::window_find_name('hilight');

    # Print the window number in red then channel name and message. // avtobiff
    if ($dest->{level} & MSGLEVEL_PUBLIC) {
      $text = "(".chr(3)."04".$dest->{window}->{refnum}.chr(15).") ".$dest->{target}.": ".$text;
    # For private chats, there is no channel name so omitt it.
    } else {
      $text = "(".chr(3)."04".$dest->{window}->{refnum}.chr(15)."): ".$text;
    }
    $window->print($text, MSGLEVEL_CLIENTCRAP) if ($window);
  }
}

$window = Irssi::window_find_name('hilight');
Irssi::print("Create a window named 'hilight'") if (!$window);

Irssi::signal_add('print text', 'sig_printtext');
