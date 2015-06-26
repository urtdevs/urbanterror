require 'open-uri'

default["urbanterror"]["listen_ports"] = [
  {
    :label => "urbanterror",
    :port => "27960",
    :protocol => "udp",
  },
]
default["urbanterror"]["version"] = "4.2.023"
default["urbanterror"]["archive"]["source"] = "https://objects.dreamhost.com:443/urt/%{version}.zip"
default["urbanterror"]["archive"]["path"] = Chef::Config[:file_cache_path] + "/urt.zip"
default["urbanterror"]["archive"]["checksum"], _ = open("https://objects.dreamhost.com:443/urt/sha256.sum") {|io| data = io.read}.split()
default["urbanterror"]["dir"] = "/opt/urbanterror"
default["urbanterror"]["user"] = "urbanterror"
default["urbanterror"]["group"] = default["urbanterror"]["user"]

default["urbanterror"]["cfg"] = {
  "hostname" => "urtdevs",
  "joinmessage" => "github.com/urtdevs",
  "motd" => "github.com/urtdevs",
  "auth" => 1,
  "auth_notoriety" => 0,
  "auth_tags" => 1,
  "auth_cheaters" => 1,
  "auth_verbosity" => 1,
  "auth_log" => 1,
  "auth_groups" => "",
  "auth_owners" => "",
  "log" => "games.log",
  "logsync" => "1",
  "loghits" => "0",
  "logroll" => "1",
  "logfile" => "0",
  "rconpassword" => "supersecret",
  "referee" => "",
}
