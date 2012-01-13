#==============================================================================
# ** Map Autoscroll
#------------------------------------------------------------------------------
# Wachunga
# Version 1.02
# 2005-12-18
# See https://github.com/wachunga/rmxp-map-autoscroll for details
#==============================================================================

#------------------------------------------------------------------------------
# * SDK Log Script
#------------------------------------------------------------------------------
SDK.log('Map Autoscroll', 'Wachunga', 1.02, '2005-12-18')

#------------------------------------------------------------------------------
# Begin SDK Enabled Check
#------------------------------------------------------------------------------
if SDK.state('Map Autoscroll') == true

  class Interpreter
    
    SCROLL_SPEED_DEFAULT = 4
    CENTER_X = (320 - 16) * 4
    CENTER_Y = (240 - 16) * 4

    #--------------------------------------------------------------------------
    # * Map Autoscroll to Coordinates
    #     x     : x coordinate to scroll to and center on
    #     y     : y coordinate to scroll to and center on
    #     speed : (optional) scroll speed (from 1-6, default being 4)
    #--------------------------------------------------------------------------
    def autoscroll(x,y,speed=SCROLL_SPEED_DEFAULT)
      if $game_map.scrolling?
        return false
      elsif not $game_map.valid?(x,y)
        print 'Map Autoscroll: given x,y is invalid'
        return command_skip
      elsif not (1..6).include?(speed)
        print 'Map Autoscroll: invalid speed (1-6 only)'
        return command_skip
      end
      max_x = ($game_map.width - 20) * 128
      max_y = ($game_map.height - 15) * 128        
      count_x = ($game_map.display_x - [0,[x*128-CENTER_X,max_x].min].max)/128
      count_y = ($game_map.display_y - [0,[y*128-CENTER_Y,max_y].min].max)/128
      if not @diag
        @diag = true
        dir = nil
        if count_x > 0
          if count_y > 0
            dir = 7
          elsif count_y < 0
            dir = 1
          end
        elsif count_x < 0
          if count_y > 0
            dir = 9
          elsif count_y < 0
            dir = 3
          end
        end
        count = [count_x.abs,count_y.abs].min
      else
        @diag = false
        dir = nil
        if count_x != 0 and count_y != 0
          return false
        elsif count_x > 0
          dir = 4
        elsif count_x < 0
          dir = 6
        elsif count_y > 0
          dir = 8
        elsif count_y < 0
          dir = 2
        end
        count = count_x != 0 ? count_x.abs : count_y.abs
      end
      $game_map.start_scroll(dir, count, speed) if dir != nil
      if @diag
        return false
      else
        return true
      end
    end
  
    #--------------------------------------------------------------------------
    # * Map Autoscroll (to Player)
    #     speed : (optional) scroll speed (from 1-6, default being 4)
    #--------------------------------------------------------------------------
    def autoscroll_player(speed=SCROLL_SPEED_DEFAULT)
      autoscroll($game_player.x,$game_player.y,speed)
    end
  
  end
  
#------------------------------------------------------------------------------
  
  class Game_Map
    
    def scroll_downright(distance)
      @display_x = [@display_x + distance, (self.width - 20) * 128].min
      @display_y = [@display_y + distance, (self.height - 15) * 128].min    
    end  
    
    def scroll_downleft(distance)
      @display_x = [@display_x - distance, 0].max    
      @display_y = [@display_y + distance, (self.height - 15) * 128].min    
    end  
    
    def scroll_upright(distance)
      @display_x = [@display_x + distance, (self.width - 20) * 128].min
      @display_y = [@display_y - distance, 0].max
    end  
    
    def scroll_upleft(distance)
      @display_x = [@display_x - distance, 0].max
      @display_y = [@display_y - distance, 0].max
    end
    
    def update_scrolling
      # If scrolling
      if @scroll_rest > 0
        # Change from scroll speed to distance in map coordinates
        distance = 2 ** @scroll_speed
        # Execute scrolling
        case @scroll_direction
#------------------------------------------------------------------------------
# Begin Map Autoscroll Edit
#------------------------------------------------------------------------------
        when 1 # down left
          scroll_downleft(distance)
#------------------------------------------------------------------------------
# End Map Autoscroll Edit
#------------------------------------------------------------------------------
        when 2  # Down
          scroll_down(distance)
#------------------------------------------------------------------------------
# Begin Map Autoscroll Edit
#------------------------------------------------------------------------------
        when 3 # down right
          scroll_downright(distance)
#------------------------------------------------------------------------------
# End Map Autoscroll Edit
#------------------------------------------------------------------------------
        when 4  # Left
          scroll_left(distance)
        when 6  # Right
          scroll_right(distance)
#------------------------------------------------------------------------------
# Begin Map Autoscroll Edit
#------------------------------------------------------------------------------
        when 7  # up left
          scroll_upleft(distance)
#------------------------------------------------------------------------------
# End Map Autoscroll Edit
#------------------------------------------------------------------------------
        when 8  # Up
          scroll_up(distance)
#------------------------------------------------------------------------------
# Begin Map Autoscroll Edit
#------------------------------------------------------------------------------
        when 9  # up right
          scroll_upright(distance)                
#------------------------------------------------------------------------------
# End Map Autoscroll Edit
#------------------------------------------------------------------------------
        end
        # Subtract distance scrolled
        @scroll_rest -= distance
      end
    end  
  end
  
#------------------------------------------------------------------------------
# End SDK Enabled Test
#------------------------------------------------------------------------------
end
