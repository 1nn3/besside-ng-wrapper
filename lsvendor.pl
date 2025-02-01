#!/usr/bin/env perl
# Usage: ./lsvendor.pl <besside.log

use strict;
use warnings;
use feature 'say';
use Text::CSV;

sub get_vendor_name {
    my ($vendor_id) = @_;

    # Öffne die CSV-Datei
    my $file = '/var/lib/ieee-data/oui.csv';
    open my $fh, '<', $file or die "Kann Datei nicht öffnen: $!";

    my $csv = Text::CSV->new( { binary => 1, auto_diag => 1 } );

    # Lese die Kopfzeile und speichere die Spaltennamen
    my $header  = $csv->getline($fh);
    my %columns = map { $header->[$_] => $_ } 0 .. $#{$header};

    # Bestimme den Index der Spalte, die du durchsuchen möchtest
    my $search_column = 'Assignment';
    my $search_index  = $columns{$search_column};

    # Überprüfe, ob die Spalte existiert
    die "Spalte '$search_column' nicht gefunden" unless defined $search_index;

    # Durchsuche die CSV-Datei nach einem bestimmten Wert
    my $search_value = $vendor_id;
    while ( my $row = $csv->getline($fh) ) {
        if ( $row->[$search_index] eq $search_value ) {
            return $row->[ $columns{'Organization Name'} ];
        }
    }
    close $fh;
    return undef;
}

for (<>) {
    chomp;
    my ( $ssid, $key, $bssid, $mac_filter ) = split( '\|', $_ );

    my $mac = $bssid;	
    $mac =~ s/^\s+|\s+$//g;    # trim

    # TODO: for the format see oui.csv
    my $vendor_id = uc substr( $mac, 0, 8 );
    $vendor_id =~ s/://g;

    say $ssid, "\t", $mac, "\t", get_vendor_name($vendor_id) || "n/a";
}

