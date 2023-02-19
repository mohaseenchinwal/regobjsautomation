use Tk;
    use Tk::StatusBar;

    my $mw = new MainWindow;

    my $Label1 = "Welcome to the statusbar";
    my $Label2 = "On";
    my $Progress = 0;

    $mw->Text()->pack(-expand => 1, -fill => 'both');

    $sb = $mw->StatusBar();

    $sb->addLabel(
        -relief         => 'flat',
        -textvariable   => \$Label1,
    );

    $sb->addLabel(
        -text           => 'double-click that -->',
        -width          => '20',
        -anchor         => 'center',
    );

    $sb->addLabel(
        -width          => 4,
        -anchor         => 'center',
        -textvariable   => \$Label2,
        -foreground     => 'blue',
        -command        => sub {$Label2 = $Label2 eq 'On' ? 'Off' : 'On';},
    );

    $sb->addLabel(
        -width          => 5,
        -anchor         => 'center',
        -textvariable   => \$Progress,
    );

    $p = $sb->addProgressBar(
        -length         => 60,
        -from           => 0,
        -to             => 100,
        -variable       => \$Progress,
    );

    $mw->repeat('50', sub {
        if ($Label2 eq 'On') {
            $Progress = 0 if (++$Progress > 100);
        }
    });

    MainLoop();
