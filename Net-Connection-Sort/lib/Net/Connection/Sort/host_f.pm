package Net::Connection::Sort::host_f;

use 5.006;
use strict;
use warnings;

=head1 NAME

Net::Connection::Sort - Sorts array of Net::Connection objects.

=head1 VERSION

Version 0.0.0

=cut

our $VERSION = '0.0.0';


=head1 SYNOPSIS

    use Net::Connection::Sort::host_f;
    use Net::Connection;
    
    my $ncs=Net::Connection::Sort::host_f->new;

=head1 METHODS

=head2 new

This initiates the module.

No arguments are taken and this will always succeed.

=cut

sub new{
	my %args;
	if(defined($_[1])){
		%args= %{$_[1]};
	};


	my $self = {
				};
    bless $self;

	return $self;
}

=head2 sort

This sorts the array of Net::Connection objects.

One object is taken and that is a array of objects.

=cut

sub sorter{
	my $self=$_[0];
	my @objects;
	if (
		defined( $_[1] ) &&
		( ref($_[1]) eq 'ARRAY' )
		){
		@objects=@{ $_[1] };
	}else{
		die 'The passed item is either not a array or undefined';
	}

	@objects=sort  {
		&helper( $a->foreign_host ) <=>  &helper( $b->foreign_host )
	} @objects;

	return @objects;
}

=head2 helper

=cut

sub helper{
        if (
			( !defined($_[0]) ) ||
			( $_[0] eq '*' ) ||
			( $_[0] =~ /[g-zG-Z]/ )
			){
			return 0;
        }
        my $host=eval { Net::IP->new( $_[0] )->intip} ;
        if (!defined( $host )){
			return 0;
        }
        return $host;
}

=head1 AUTHOR

Zane C. Bowers-Hadley, C<< <vvelox at vvelox.net> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-net-connection-sort at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=Net-Connection-Sort>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Net::Connection::Sort


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<https://rt.cpan.org/NoAuth/Bugs.html?Dist=Net-Connection-Sort>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Net-Connection-Sort>

=item * CPAN Ratings

L<https://cpanratings.perl.org/d/Net-Connection-Sort>

=item * Search CPAN

L<https://metacpan.org/release/Net-Connection-Sort>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2019 by Zane C. Bowers-Hadley.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)


=cut

1; # End of Net::Connection::Sort
