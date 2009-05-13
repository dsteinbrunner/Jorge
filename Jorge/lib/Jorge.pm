package Jorge;

use warnings;
use strict;

=head1 NAME

Jorge - ORM Made simple.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Not ready for Class::DBI or DBIx::Class? Dissapointed by Tangram? Still
writting your own SQL?

Then, you may benefit from Jorge.

Jorge is a simple ORM (Object Relational Mapper) that will let you
quick and easily interface your perl objects with a MySQL database
(Suppport for PostgreSQL may arrive some day)

Usual operations are covered (insert, update, select, delete, count) but
if you need JOINS or other type of queries, you should be looking for
other library (DBIx::Class or Rose::DB::Object)

Jorge won't solve all your problems and may not be what you need, but if
it covers your needs, you'll find it ultra easy to use, intuitive and 
will get used to it sooner that you may think.


=head1 USAGE

=head2 Defining your new Jorge based class

=head3 YourClass.pm

    package YourClass
    use base Jorge::DBEntity;

    sub _fields {

        my $table_name = 'User';

        my @fields = qw(
            Id
            Password
            Email
            Date
            Md5
        );

        my %fields = (
            Id => { pk => 1, read_only => 1 },
            Date => { datetime => 1},
        );

        return [ \@fields, \%fields, $table_name ];
    }
    ;1




That is enough to get you started with Jorge.
Now, you need to provide Jorge with a config file containing
the database info (this is likely to change in future and add options,
like passing the config info as parameters)

create a config/config.yml file (in your current working dir, relative
to the path the instance script will be working)

=head3 config/config.yml

    database:
        host: DB_HOST
        db: DB_NAME
        user: DB_USER
        password: USER_PASSWORD

This is what the config file should have. Plain simple. Since it's YAML,
you will want to double check the syntax looking for tabs/spaces.


Now, you can create a instance script and try the next.

=head3 YourInstanceScript.pl

    #!/usr/bin/perl
    use User;

    my $user = User->new(Email => 'jorge@foo.com', Password => 'sshhhhh');

    #or

    my $another_user = User->new();
    $another_user->Email('jorge@foo.com');
    $another_user->Password('sshhhhh');

If the database info you provided in the config file was accurate and you
already created the database (Jorge will not create your database, at least, 
not now, but likely to change in next versions) You should be able now to
start interacting with it.

Try now something like this, later on your instance script:

    $user->insert;
    print $user->Id; #if the insert was successful, you $user->Id should
    #return the inserted id. 

Ideally, that should have worked fine and now you can start using Jorge.

Available method for Jorge::DBEntity based classes are:

=over 2

=item insert

=item update

=item delete

=item get_by

All those methods are pretty self explanatory, but this should guide you
through the basic operations

=back

=head3 YourInstanceScript.pl

    #!/usr/bin/perl
    use User;

    my $user = User->new(Email => 'jorge@foo.com', Password => 'sshhhhh');
    $user->insert;
    #now $user->Id returns the inserted id from the database
    $user->Email('updated_mail@bar.com');
    $user->update;
    #same $user->Id, but $user->Email was updated in the database
    $user->delete
    #now, even while the $user exists in memory, is not present anymore on
    the database

    #now, let's try something more complex
    my $user2 = User->new(Email => 'coco@foo.com', Password => 'secret');
    $user2->get_by(qw[Email Password]);
    print $user2->Id;
    # Now, if there is a User in with Email = 'coco@foo.com' AND a Password
    # = 'secret' then $user2->Id will be a positive integer. Otherwhise, it
    # will return undef

    $user2->get_by('Email'); #will look only for the Email field.


As you can see, you should ALLWAYS check your object to confirm that it 
found at match before using it.

I'm considering implementing some error checking method, but since I got
used to check for Id's on my objects.

If you have a proposal to solve this, feel free to email or open a 
request ticket on CPAN Request Tracker at:
L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Jorge>
    
Another thing to consider is that, even if the get_by() method finds more 
than one match, it will allways use the first one.    

=head1 AUTHORS

Mondongo, C<< <mondongo at gmail.com> >> Did the important job and started 
this beauty.

Julian Porta, C<< <julian.porta at gmail.com> >> took the code and tried 
to make it harder, better, faster, stronger.

=head1 BUGS

Please report any bugs or feature requests to C<bug-jorge at rt.cpan.org>,
or through the web interface at 
 L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Jorge>.  
I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Jorge


You can also look for information at:

=over 4

=item * Github Project Page

L<http://github.com/Porta/Jorge/tree/master>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Jorge>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Jorge>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Jorge>

=item * Search CPAN

L<http://search.cpan.org/dist/Jorge/>

=back


=head1 ACKNOWLEDGEMENTS

Mondongo C<< <mondongo at gmail.com> >> For starting this.

=head1 COPYRIGHT & LICENSE

Copyright 2009 Julian Porta, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1; # End of Jorge