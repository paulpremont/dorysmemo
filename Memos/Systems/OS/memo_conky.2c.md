==========================================================
                       C O N K Y
==========================================================

Personnaliser son fond d'écran.
Afficher les ressources de son système.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Docs:

        http://doc.ubuntu-fr.org/conky
        http://conky.sourceforge.net/screenshots.html

    Templates:

        http://desktopspotting.com/26/best-conky-configs-for-linux-desktop/
        http://free.doc.free.fr/conky/conky.html

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

    > apt-get install conky-all
    ou
    > apt-get install conky

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

    > vim ~/.conkyrc

    Voir les exemples des liens donnés

        --------------------------
        Exemple avec conky lua
        --------------------------

                http://www.webupd8.org/2011/02/try-this-great-looking-conky-lua.html

                __________________________
                conkyrc:
        
                    > vim ~/.conkyrc

                        # Conky settings #
                        background no
                        update_interval 1

                        cpu_avg_samples 2
                        net_avg_samples 2

                        override_utf8_locale yes

                        double_buffer yes
                        no_buffers yes

                        text_buffer_size 2048
                        #imlib_cache_size 0

                        temperature_unit fahrenheit

                        # Window specifications #

                        own_window yes
                        own_window_type override
                        own_window_transparent yes
                        own_window_hints undecorate,sticky,skip_taskbar,skip_pager,below

                        border_inner_margin 0
                        border_outer_margin 0

                        minimum_size 200 250
                        maximum_width 200

                        alignment tr
                        gap_x 35
                        gap_y 55

                        # Graphics settings #
                        draw_shades no
                        draw_outline no
                        draw_borders no
                        draw_graph_borders no

                        # Text settings #
                        use_xft yes
                        xftfont caviar dreams:size=8
                        xftalpha 0.5

                        uppercase no

                        temperature_unit celsius


                        default_color FFFFFF

                        # Lua Load  #
                        lua_load ~/.lua/scripts/clock_rings.lua
                        lua_draw_hook_pre clock_rings

                        TEXT
                        ${voffset 8}${color FF6600}${font caviar dreams:size=16}${time %A}${font}${voffset -8}${alignr 50}${color FFFFFF}${font caviar dreams:size=38}${time %e}${font}
                        ${color FFFFFF}${voffset -30}${color FFFFFF}${font caviar dreams:size=18}${time %b}${font}${voffset -3} ${color FFFFFF}${font caviar dreams:size=20}${time %Y}${font}${color FF6600}${hr}
                        ${voffset 140}${font caviar dreams:size=10}${alignr}HOME${font}
                        # ${font caviar dreams:size=12}${color FFFFFF}${alignr}${weather http://weather.noaa.gov/pub/data/observations/metar/stations/ LQBK temperature temperature 30} °C${font}
                        ${image ~/.conky/new-ubuntu-logo.png -p 64,125 -s 70x20}

                        ${color FFFFFF}${goto 25}${voffset 35}${cpu cpu0}%
                        ${color FF6600}${goto 25}CPU
                        ${color FFFFFF}${goto 50}${voffset 23}${memperc}%
                        ${color FF6600}${goto 50}RAM
                        ${color FFFFFF}${goto 75}${voffset 23}${swapperc}%
                        ${color FF6600}${goto 75}Swap
                        ${color FFFFFF}${goto 100}${voffset 23}${fs_used_perc /}%
                        ${color FF6600}${goto 100}Disk
                        ${color FFFFFF}${goto 125}${voffset 25}${downspeed eth0}
                        ${color FFFFFF}${goto 125}${upspeed eth0}
                        ${color FF6600}${goto 125}Net



                        ${color FFFFFF}${font caviar dreams:size=8}Uptime: ${uptime_short}
                        ${color FFFFFF}${font caviar dreams:size=8}Processes: ${processes}
                        ${color FFFFFF}${font caviar dreams:size=8}Running: ${running_processes}


                        ${color FF6600}${font caviar dreams:size=8}${alignr}${nodename}
                        ${color FF6600}${font caviar dreams:size=8}${alignr}${pre_exec cat /etc/issue.net}  $machine
                        ${color FF6600}${font caviar dreams:size=8}${alignr}Kernel: ${kernel}




                __________________________
                lua:

                    > vim ~/.lua/.scripts/clock_rings.lua

                        --[[
                        Clock Rings by Linux Mint (2011) reEdited by despot77

                        This script draws percentage meters as rings, and also draws clock hands if you want! It is fully customisable; all options are described in the script. This script is based off a combination of my clock.lua script and my rings.lua script.

                        IMPORTANT: if you are using the 'cpu' function, it will cause a segmentation fault if it tries to draw a ring straight away. The if statement on line 145 uses a delay to make sure that this doesn't happen. It calculates the length of the delay by the number of updates since Conky started. Generally, a value of 5s is long enough, so if you update Conky every 1s, use update_num>5 in that if statement (the default). If you only update Conky every 2s, you should change it to update_num>3; conversely if you update Conky every 0.5s, you should use update_num>10. ALSO, if you change your Conky, is it best to use "killall conky; conky" to update it, otherwise the update_num will not be reset and you will get an error.

                        To call this script in Conky, use the following (assuming that you save this script to ~/scripts/rings.lua):
                            lua_load ~/scripts/clock_rings.lua
                            lua_draw_hook_pre clock_rings
                            
                        Changelog:
                        + v1.0 -- Original release (30.09.2009)
                           v1.1p -- Jpope edit londonali1010 (05.10.2009)
                        *v 2011mint -- reEdit despot77 (18.02.2011)
                        ]]

                        settings_table = {
                            {
                                -- Edit this table to customise your rings.
                                -- You can create more rings simply by adding more elements to settings_table.
                                -- "name" is the type of stat to display; you can choose from 'cpu', 'memperc', 'fs_used_perc', 'battery_used_perc'.
                                name='time',
                                -- "arg" is the argument to the stat type, e.g. if in Conky you would write ${cpu cpu0}, 'cpu0' would be the argument. If you would not use an argument in the Conky variable, use ''.
                                arg='%I.%M',
                                -- "max" is the maximum value of the ring. If the Conky variable outputs a percentage, use 100.
                                max=12,
                                -- "bg_colour" is the colour of the base ring.
                                bg_colour=0xffffff,
                                -- "bg_alpha" is the alpha value of the base ring.
                                bg_alpha=0.1,
                                -- "fg_colour" is the colour of the indicator part of the ring.
                                fg_colour=0xFF6600,
                                -- "fg_alpha" is the alpha value of the indicator part of the ring.
                                fg_alpha=0.2,
                                -- "x" and "y" are the x and y coordinates of the centre of the ring, relative to the top left corner of the Conky window.
                                x=100, y=150,
                                -- "radius" is the radius of the ring.
                                radius=50,
                                -- "thickness" is the thickness of the ring, centred around the radius.
                                thickness=5,
                                -- "start_angle" is the starting angle of the ring, in degrees, clockwise from top. Value can be either positive or negative.
                                start_angle=0,
                                -- "end_angle" is the ending angle of the ring, in degrees, clockwise from top. Value can be either positive or negative, but must be larger than start_angle.
                                end_angle=360
                            },
                            {
                                name='time',
                                arg='%M.%S',
                                max=60,
                                bg_colour=0xffffff,
                                bg_alpha=0.1,
                                fg_colour=0xFF6600,
                                fg_alpha=0.4,
                                x=100, y=150,
                                radius=56,
                                thickness=5,
                                start_angle=0,
                                end_angle=360
                            },
                            {
                                name='time',
                                arg='%S',
                                max=60,
                                bg_colour=0xffffff,
                                bg_alpha=0.1,
                                fg_colour=0xFF6600,
                                fg_alpha=0.6,
                                x=100, y=150,
                                radius=62,
                                thickness=5,
                                start_angle=0,
                                end_angle=360
                            },
                            {
                                name='time',
                                arg='%d',
                                max=31,
                                bg_colour=0xffffff,
                                bg_alpha=0.1,
                                fg_colour=0xFF6600,
                                fg_alpha=0.8,
                                x=100, y=150,
                                radius=70,
                                thickness=5,
                                start_angle=-90,
                                end_angle=90
                            },
                            {
                                name='time',
                                arg='%m',
                                max=12,
                                bg_colour=0xffffff,
                                bg_alpha=0.1,
                                fg_colour=0xFF6600,
                                fg_alpha=1,
                                x=100, y=150,
                                radius=76,
                                thickness=5,
                                start_angle=-90,
                                end_angle=90
                            },
                            {
                                name='cpu',
                                arg='cpu0',
                                max=100,
                                bg_colour=0xffffff,
                                bg_alpha=0.2,
                                fg_colour=0xFF6600,
                                fg_alpha=0.8,
                                x=50, y=300,
                                radius=25,
                                thickness=5,
                                start_angle=-90,
                                end_angle=180
                            },
                            {
                                name='memperc',
                                arg='',
                                max=100,
                                bg_colour=0xffffff,
                                bg_alpha=0.2,
                                fg_colour=0xFF6600,
                                fg_alpha=0.8,
                                x=75, y=350,
                                radius=25,
                                thickness=5,
                                start_angle=-90,
                                end_angle=180
                            },
                            {
                                name='swapperc',
                                arg='',
                                max=100,
                                bg_colour=0xffffff,
                                bg_alpha=0.2,
                                fg_colour=0xFF6600,
                                fg_alpha=0.8,
                                x=100, y=400,
                                radius=25,
                                thickness=5,
                                start_angle=-90,
                                end_angle=180
                            },
                            {
                                name='fs_used_perc',
                                arg='/',
                                max=100,
                                bg_colour=0xffffff,
                                bg_alpha=0.2,
                                fg_colour=0xFF6600,
                                fg_alpha=0.8,
                                x=125, y=450,
                                radius=25,
                                thickness=5,
                                start_angle=-90,
                                end_angle=180
                            },
                                {
                                name='downspeedf',
                                arg='eth0',
                                max=100,
                                bg_colour=0xffffff,
                                bg_alpha=0.2,
                                fg_colour=0x339900,
                                fg_alpha=0.8,
                                x=150, y=500,
                                radius=25,
                                thickness=4,
                                start_angle=-90,
                                end_angle=180
                            },
                                {
                                name='upspeedf',
                                arg='eth0',
                                max=100,
                                bg_colour=0xffffff,
                                bg_alpha=0.2,
                                fg_colour=0xff6600,
                                fg_alpha=0.8,
                                x=150, y=500,
                                radius=20,
                                thickness=4,
                                start_angle=-90,
                                end_angle=180
                            },
                        }

                        -- Use these settings to define the origin and extent of your clock.

                        clock_r=65

                        -- "clock_x" and "clock_y" are the coordinates of the centre of the clock, in pixels, from the top left of the Conky window.

                        clock_x=100
                        clock_y=150

                        show_seconds=true

                        require 'cairo'

                        function rgb_to_r_g_b(colour,alpha)
                            return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
                        end

                        function draw_ring(cr,t,pt)
                            local w,h=conky_window.width,conky_window.height
                            
                            local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
                            local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

                            local angle_0=sa*(2*math.pi/360)-math.pi/2
                            local angle_f=ea*(2*math.pi/360)-math.pi/2
                            local t_arc=t*(angle_f-angle_0)

                            -- Draw background ring

                            cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
                            cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
                            cairo_set_line_width(cr,ring_w)
                            cairo_stroke(cr)
                            
                            -- Draw indicator ring

                            cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
                            cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
                            cairo_stroke(cr)        
                        end

                        function draw_clock_hands(cr,xc,yc)
                            local secs,mins,hours,secs_arc,mins_arc,hours_arc
                            local xh,yh,xm,ym,xs,ys
                            
                            secs=os.date("%S")    
                            mins=os.date("%M")
                            hours=os.date("%I")
                                
                            secs_arc=(2*math.pi/60)*secs
                            mins_arc=(2*math.pi/60)*mins+secs_arc/60
                            hours_arc=(2*math.pi/12)*hours+mins_arc/12
                                
                            -- Draw hour hand
                            
                            xh=xc+0.7*clock_r*math.sin(hours_arc)
                            yh=yc-0.7*clock_r*math.cos(hours_arc)
                            cairo_move_to(cr,xc,yc)
                            cairo_line_to(cr,xh,yh)
                            
                            cairo_set_line_cap(cr,CAIRO_LINE_CAP_ROUND)
                            cairo_set_line_width(cr,5)
                            cairo_set_source_rgba(cr,1.0,1.0,1.0,1.0)
                            cairo_stroke(cr)
                            
                            -- Draw minute hand
                            
                            xm=xc+clock_r*math.sin(mins_arc)
                            ym=yc-clock_r*math.cos(mins_arc)
                            cairo_move_to(cr,xc,yc)
                            cairo_line_to(cr,xm,ym)
                            
                            cairo_set_line_width(cr,3)
                            cairo_stroke(cr)
                            
                            -- Draw seconds hand
                            
                            if show_seconds then
                                xs=xc+clock_r*math.sin(secs_arc)
                                ys=yc-clock_r*math.cos(secs_arc)
                                cairo_move_to(cr,xc,yc)
                                cairo_line_to(cr,xs,ys)
                            
                                cairo_set_line_width(cr,1)
                                cairo_stroke(cr)
                            end
                        end

                        function conky_clock_rings()
                            local function setup_rings(cr,pt)
                                local str=''
                                local value=0
                                
                                str=string.format('${%s %s}',pt['name'],pt['arg'])
                                str=conky_parse(str)
                                
                                value=tonumber(str)
                                pct=value/pt['max']
                                
                                draw_ring(cr,pct,pt)
                            end
                            
                            -- Check that Conky has been running for at least 5s

                            if conky_window==nil then return end
                            local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)
                            
                            local cr=cairo_create(cs)    
                            
                            local updates=conky_parse('${updates}')
                            update_num=tonumber(updates)
                            
                            if update_num>5 then
                                for i in pairs(settings_table) do
                                    setup_rings(cr,settings_table[i])
                                end
                            end
                            
                            draw_clock_hands(cr,clock_x,clock_y)
                        end



                __________________________
                Copie du png

            > cp new-ubuntu-logo.png ~./conky/


~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Execution:

        > conky
        > conky -d -q #mode deamon + quiet

~~~~~~~~~~~~~~~~~~~~~~~~~~
subtitle 1
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        subtitle 2
        --------------------------
                __________________________
                subtitle 3

                        subtitle 4
                        ``````````````````````````
