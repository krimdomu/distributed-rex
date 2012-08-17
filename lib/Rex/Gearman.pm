#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package Rex::Gearman;

use strict;
use warnings;

our $VERSION = "0.0.2";

=head1 Rex::Gearman - Distributed Rex

Distibuted Rex is a addition to Rex for distributed Task execution with the help of gearman. So it is possible to scale rex.

Distributed Rex is setup of two components. One (or more) Worker and one Client. As more worker you run as more parallel tasks you are able to execute.

=head1 INSTALLATION

If you want to test Distributed Rex you have to follow these steps. But keep in mind, this is work in progress. It may crash your systems and eat all your jelly beans and pretzel sticks. And even worse - drink all your beer. You have been warned!


=head2 On the Client

First you have to download the development branch of Rex 0.32.

 git clone git://github.com/krimdomu/Rex.git rex
 cd rex
 perl Makefile.PL
 make
 make test (perhaps you need to skip this)
 make install

After that you have to install the Gearman Perl modules.

 curl -L cpanmin.us | perl - --sudo -n Gearman::Client

Now you can install Distributed Rex.

 git clone git://github.com/krimdomu/distributed-rex.git
 cd distributed-rex
 perl Makefile.PL
 make
 make install


=head2 On the server (worker)

First you have to install gearman and start it. 

After that you have to distribute your Rexfile (and all associated files (like templates, the "lib" directory, ssh keys, ...) to your worker machines. Please be carefull to name the directory where the Rexfile lives in exact the same way as on your client machine!

Now you have to install the Gearman Perl modules.

 curl -L cpanmin.us | perl - --sudo -n Gearman::Worker

And Distributed Rex.

 git clone git://github.com/krimdomu/distributed-rex.git
 cd distributed-rex
 perl Makefile.PL
 make
 make install

Now change into the directory where your I<Rexfile> is located and create a file I<worker.conf>.

Here you have to configure all your gearmand servers so that the Worker module can register its functions to them.

 {
    job_servers => [
      "127.0.0.1:4730",
      "192.168.7.10:4730",
      "192.168.7.11:4730",
    ],
 };

Now you are able to start the workerprocess.

 rex-gearman-worker -d

=head1 RUNNING A TASK

Change to the directory where your I<Rexfile> lives and create a file called I<client.conf>. In this file you have to configure your gearmand servers.

 {
    job_servers => [
      "127.0.0.1:4730",
      "192.168.7.10:4730",
      "192.168.7.11:4730",
    ],
 };


Now you're able to run your tasks as known. But you have to replace the I<rex> command with I<rex-gearman-client>. The CLI parameter are the same. So you can use I<rex-gearman-client> the same way as you used I<rex>.

For example:

 rex-gearman-client -h
 rex-gearman-client -Tv
 rex-gearman-client prepare


=head1 REPORTING BUGS

Please report the bugs in the Issue-Tracker.

=head1 GETTING HELP

If you need help, you can join us on irc on irc.freenode.net channel #rex.



1;
