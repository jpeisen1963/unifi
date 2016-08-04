# unifi
Hacks and software used to help manage my Unifi installation

  ec - a script to convert the output of configure's show command
       to one-liners.

  usg_diff - a command to generate a suitable config.gateway.json
       file, using the existing version. the system.cfg file, and
       the output of "mca_ctrl -t dump_cfg" from the USG.

  usg_diff_cron - an example script showing how usg_diff could be used.
