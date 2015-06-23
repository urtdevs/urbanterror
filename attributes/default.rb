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
