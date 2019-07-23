package Net::Connection::Sort;

use 5.006;
use strict;
use warnings;
use base 'Error::Helper';

=head1 NAME

Net::Connection::Sort - Sorts array of Net::Connection objects.

=head1 VERSION

Version 0.0.0

=cut

our $VERSION = '0.0.0';


=head1 SYNOPSIS

    use Net::Connection::Sort;
    use Net::Connection;
    
    my $sort_args={
                  type=>'host_f',
                  invert=>0,
                  };
    
    my $mcs;
    eval{
        $ncs=Net::Connection::Sort->new( $sort_args );
    };
    
    if ( ! defined( $mcs ) ){
        print "Failed to init the sorter... ".$@;
    }

=head1 METHODS

=head2 new

This initiates the module.

One argument is taken and that is a hash ref with two possible keys,
'type' and 'invert'. If not passed or any of the keys are undef, then
the defaults will be used.

'type' is the module to use. It is relative to 'Net::Connection::Sort',
so 'host_f' becomes 'Net::Connection::Sort::host_f'.

    my $sort_args={
                  type=>'host_f',
                  invert=>0,
                  };
    
    my $mcs;
    eval{
        $ncs=Net::Connection::Sort->new( $sort_args );
    };
    
    if ( ! defined( $mcs ) ){
        print "Failed to init the sorter... ".$@;
    }

=cut

sub new{
	my %args;
	if(defined($_[1])){
		%args= %{$_[1]};
	};


	my $self = {
				perror=>undef,
				error=>undef,
				errorString=>"",
				testing=>0,
				errorExtra=>{
							 flags=>{
									 }
							 },
				type=>'host_f',
				invert=>0,
				sorter=>undef,,
				};
    bless $self;

	# real in the args if needed
	if (defined( $args{type} )){
		$self->{type}=$args{type};
	}
	if (defined( $args{invert} )){
		$self->{invert}=$args{invert};
	}

	# see of we amd reel in the module
	my $to_eval='use Net::Connection::Sort::'.$self->{type}
	.'; $self->{sorter}=Net::Connection::Sort::'.$self->{type}.'->new;';
	eval( $to_eval ) or die('Failed to use or invoke Net::Connection::Sort::'.$self->{type}.'->new... '.$@);

	# make sure we did get it
	if (!defined( $self->{sorter} )){
		die( 'Net::Connection::Sort::'.$self->{type}.'->new returned undef');
	}

	return $self;
}

=head2 sort

This sorts the array of Net::Connection objects.

One object is taken and that is a array of objects.

=cut

sub sorter{
	my $self=$_[0];
	my @objects;
	if(defined($_[1])){
		@objects= @{$_[1]};
	};

	if( ! $self->errorblank ){
		return undef;
	}

	return $self->{sorter}->sorter( \@objects );
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
