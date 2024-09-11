[private_instances]
%{ for ip in private_ips ~}
${ip}
%{ endfor ~}
