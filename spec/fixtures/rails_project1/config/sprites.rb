Sprites.application.define do
  sprite :bas

  sprite "buttons.png" => "buttons.css" do
    sprite_piece 'buttons/btn-black-default-28.png' => 'a.black.wf_button > span, button.black.wf_submit span'
    sprite_piece 'buttons/btn-black-default-cap-28.png' => 'a.black.wf_button, button.black.wf_submit', :x => 'right'
    sprite_piece 'buttons/btn-black-rollover-28.png' => 'a.black.wf_button:hover > span, button.black.wf_submit:hover span'
    sprite_piece 'buttons/btn-black-rollover-cap-28.png' => 'a.black.wf_button:hover, button.black.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/btn-black-onclick-28.png' => 'a.black.wf_button:active > span, button.black.wf_submit:active span, a.black.wf_button.active span'
    sprite_piece 'buttons/btn-black-onclick-cap-28.png' => 'a.black.wf_button:active, button.black.wf_submit:active, a.black.wf_button.active', :x => 'right'
    sprite_piece 'buttons/btn-green-default.png' => 'a.green.wf_button > span, button.green.wf_submit span'
    sprite_piece 'buttons/btn-green-default-cap.png' => 'a.green.wf_button, button.green.wf_submit', :x => 'right'
    sprite_piece 'buttons/btn-green-rollover.png' => 'a.green.wf_button:hover > span, button.green.wf_submit:hover span'
    sprite_piece 'buttons/btn-green-rollover-cap.png' => 'a.green.wf_button:hover, button.green.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/btn-green-onclick.png' => 'a.green.wf_button:active > span, button.green.wf_submit:active span'
    sprite_piece 'buttons/btn-green-onclick-cap.png' => 'a.green.wf_button:active, button.green.wf_submit:active', :x => 'right'
    sprite_piece 'buttons/btn-green-default-edge.png' => 'a.right_edge.green.wf_button, button.right_edge.green.wf_submit', :x => 'right'
    sprite_piece 'buttons/btn-green-rollover-edge.png' => 'a.right_edge.green.wf_button:hover button.right_edge.green.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/btn-green-onclick-edge.png' => 'a.right_edge.green.wf_button:active, button.right_edge.green.wf_submit:active', :x => 'right'
    sprite_piece 'buttons/btn-green-default-drop.png' => 'a.green.wf_menu_button'
    sprite_piece 'buttons/btn-green-rollover-drop.png' => 'a.green.wf_menu_button:hover'
    sprite_piece 'buttons/btn-green-onclick-drop.png' => 'a.green.wf_menu_button:active'
    sprite_piece 'buttons/btn-black-default.png' => 'a.tall.black.wf_button > span, button.tall.black.wf_submit span'
    sprite_piece 'buttons/btn-black-default-cap-long.png' => 'a.tall.black.wf_button, button.tall.black.wf_submit, a.black.back_arrow.wf_button', :x => 'right'
    sprite_piece 'buttons/btn-black-rollover.png' => 'a.tall.black.wf_button:hover > span, button.tall.black.wf_submit:hover span'
    sprite_piece 'buttons/btn-black-rollover-cap-long.png' => 'a.tall.black.wf_button:hover, button.tall.black.wf_submit:hover, a.black.back_arrow.wf_button:hover', :x => 'right'
    sprite_piece 'buttons/btn-black-onclick.png' => 'a.tall.black.wf_button:active > span, button.tall.black.wf_submit:active span, a.black.tall.wf_button.active span'
    sprite_piece 'buttons/btn-black-onclick-cap-long.png' => 'a.tall.black.wf_button:active, button.tall.black.wf_submit:active, a.black.back_arrow.wf_button:active, a.black.tall.wf_button.active', :x => 'right'
    sprite_piece 'buttons/btn-red-default.png' => 'a.red.wf_button > span, button.red.wf_submit span'
    sprite_piece 'buttons/btn-red-default-cap.png' => 'a.red.wf_button, button.red.wf_submit', :x => 'right'
    sprite_piece 'buttons/btn-red-rollover.png' => 'a.red.wf_button:hover > span, button.red.wf_submit:hover span'
    sprite_piece 'buttons/btn-red-rollover-cap.png' => 'a.red.wf_button:hover, button.red.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/btn-red-onclick.png' => 'a.red.wf_button:active > span, button.red.wf_submit:active span'
    sprite_piece 'buttons/btn-red-onclick-cap.png' => 'a.red.wf_button:active, button.red.wf_submit:active', :x => 'right'
    sprite_piece 'buttons/btn-yellow-default.png' => 'a.yellow.wf_button > span, button.yellow.wf_submit span'
    sprite_piece 'buttons/btn-yellow-default-cap.png' => 'a.yellow.wf_button, button.yellow.wf_submit', :x => 'right'
    sprite_piece 'buttons/btn-yellow-rollover.png' => 'a.yellow.wf_button:hover > span, button.yellow.wf_submit:hover span'
    sprite_piece 'buttons/btn-yellow-rollover-cap.png' => 'a.yellow.wf_button:hover, button.yellow.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/btn-yellow-onclick.png' => 'a.yellow.wf_button:active > span, button.yellow.wf_submit:active span'
    sprite_piece 'buttons/btn-yellow-onclick-cap.png' => 'a.yellow.wf_button:active, button.yellow.wf_submit:active', :x => 'right'
    sprite_piece 'buttons/btn-white-default.png' => 'a.white.wf_button > span, button.white.wf_submit span'
    sprite_piece 'buttons/btn-white-default-cap.png' => 'a.white.wf_button, button.white.wf_submit', :x => 'right'
    sprite_piece 'buttons/btn-white-rollover.png' => 'a.white.wf_button:hover > span, button.white.wf_submit:hover span'
    sprite_piece 'buttons/btn-white-rollover-cap.png' => 'a.white.wf_button:hover, button.white.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/btn-white-onclick.png' => 'a.white.wf_button:active > span, button.white.wf_submit:active span'
    sprite_piece 'buttons/btn-white-onclick-cap.png' => 'a.white.wf_button:active, button.white.wf_submit:active', :x => 'right'
    sprite_piece 'buttons/btn-trans-default.png' => 'a.trans.wf_button > span, button.trans.wf_submit span'
    sprite_piece 'buttons/btn-trans-default-cap.png' => 'a.trans.wf_button, button.trans.wf_submit', :x => 'right'
    sprite_piece 'buttons/btn-trans-rollover.png' => 'a.trans.wf_button:hover > span, button.trans.wf_submit:hover span'
    sprite_piece 'buttons/btn-trans-rollover-cap.png' => 'a.trans.wf_button:hover, button.trans.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/btn-trans-onclick.png' => 'a.trans.wf_button:active > span, button.trans.wf_submit:active span'
    sprite_piece 'buttons/btn-trans-onclick-cap.png' => 'a.trans.wf_button:active, button.trans.wf_submit:active', :x => 'right'
    sprite_piece 'buttons/btn-blue-default.png' => 'a.blue.wf_button > span, button.blue.wf_submit span'
    sprite_piece 'buttons/btn-blue-default-cap.png' => 'a.blue.wf_button, button.blue.wf_submit', :x => 'right'
    sprite_piece 'buttons/btn-blue-rollover.png' => 'a.blue.wf_button:hover > span, button.blue.wf_submit:hover span'
    sprite_piece 'buttons/btn-blue-rollover-cap.png' => 'a.blue.wf_button:hover, button.blue.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/btn-blue-onclick.png' => 'a.blue.wf_button:active > span, button.blue.wf_submit:active span'
    sprite_piece 'buttons/btn-blue-onclick-cap.png' => 'a.blue.wf_button:active, button.blue.wf_submit:active', :x => 'right'
    sprite_piece 'buttons/btn-red-default-edge.png' => 'a.right_edge.red.wf_button, button.right_edge.red.wf_submit', :x => 'right'
    sprite_piece 'buttons/btn-red-rollover-edge.png' => 'a.right_edge.red.wf_button:hover, button.right_edge.red.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/btn-red-onclick-edge.png' => 'a.right_edge.red.wf_button:active, button.right_edge.red.wf_submit:active', :x => 'right'
    sprite_piece 'buttons/btn-red-default-drop.png' => 'a.red.wf_menu_button'
    sprite_piece 'buttons/btn-red-rollover-drop.png' => 'a.red.wf_menu_button:hover'
    sprite_piece 'buttons/btn-red-onclick-drop.png' => 'a.red.wf_menu_button:active'
    sprite_piece 'buttons/btn-yellow-default-edge.png' => 'a.right_edge.yellow.wf_button, button.right_edge.yellow.wf_submit', :x => 'right'
    sprite_piece 'buttons/btn-yellow-rollover-edge.png' => 'a.right_edge.yellow.wf_button:hover, button.right_edge.yellow.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/btn-yellow-onclick-edge.png' => 'a.right_edge.yellow.wf_button:active, button.right_edge.yellow.wf_submit:active', :x => 'right'
    sprite_piece 'buttons/btn-yellow-default-drop.png' => 'a.yellow.wf_menu_button'
    sprite_piece 'buttons/btn-yellow-rollover-drop.png' => 'a.yellow.wf_menu_button:hover'
    sprite_piece 'buttons/btn-yellow-onclick-drop.png' => 'a.yellow.wf_menu_button:active'
    sprite_piece 'buttons/btn-blue-default-edge.png' => 'a.right_edge.blue.wf_button, button.right_edge.blue.wf_submit', :x => 'right'
    sprite_piece 'buttons/btn-blue-rollover-edge.png' => 'a.right_edge.blue.wf_button:hover, button.right_edge.blue.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/btn-blue-onclick-edge.png' => 'a.right_edge.blue.wf_button:active, button.right_edge.blue.wf_submit:active', :x => 'right'
    sprite_piece 'buttons/btn-blue-default-drop.png' => 'a.blue.wf_menu_button'
    sprite_piece 'buttons/btn-blue-rollover-drop.png' => 'a.blue.wf_menu_button:hover'
    sprite_piece 'buttons/btn-blue-onclick-drop.png' => 'a.blue.wf_menu_button:active'
    sprite_piece 'buttons/btn-white-default-edge.png' => 'a.right_edge.white.wf_button, button.right_edge.white.wf_submit', :x => 'right'
    sprite_piece 'buttons/btn-white-rollover-edge.png' => 'a.right_edge.white.wf_button:hover, button.right_edge.white.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/btn-white-onclick-edge.png' => 'a.right_edge.white.wf_button:active, button.right_edge.white.wf_submit:active', :x => 'right'
    sprite_piece 'buttons/btn-white-default-drop.png' => 'a.white.wf_menu_button'
    sprite_piece 'buttons/btn-white-rollover-drop.png' => 'a.white.wf_menu_button:hover'
    sprite_piece 'buttons/btn-white-onclick-drop.png' => 'a.white.wf_menu_button:active'
    sprite_piece 'buttons/btn-trans-default-edge.png' => 'a.right_edge.trans.wf_button, button.right_edge.trans.wf_submit', :x => 'right'
    sprite_piece 'buttons/btn-trans-rollover-edge.png' => 'a.right_edge.trans.wf_button:hover, button.right_edge.trans.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/btn-trans-onclick-edge.png' => 'a.right_edge.trans.wf_button:active, button.right_edge.trans.wf_submit:active', :x => 'right'
    sprite_piece 'buttons/btn-trans-default-drop.png' => 'a.trans.wf_menu_button'
    sprite_piece 'buttons/btn-trans-rollover-drop.png' => 'a.trans.wf_menu_button:hover'
    sprite_piece 'buttons/btn-trans-onclick-drop.png' => 'a.trans.wf_menu_button:active'
    sprite_piece 'buttons/btn-blackarrow-default.png' => 'a.black.back_arrow.wf_button > span'
    sprite_piece 'buttons/btn-blackarrow-rollover.png' => 'a.black.back_arrow.wf_button:hover > span'
    sprite_piece 'buttons/btn-blackarrow-onclick.png' => 'a.black.back_arrow.wf_button:active > span'
    sprite_piece 'buttons/dark_background/btn-blue-default.png' => 'a.blue.dark_background.wf_button > span, button.blue.dark_background.wf_submit span'
    sprite_piece 'buttons/dark_background/btn-blue-default-cap.png' => 'a.blue.dark_background.wf_button, button.blue.dark_background.wf_submit', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-blue-rollover.png' => 'a.blue.dark_background.wf_button:hover > span, button.blue.dark_background.wf_submit:hover span'
    sprite_piece 'buttons/dark_background/btn-blue-rollover-cap.png' => 'a.blue.dark_background.wf_button:hover, button.blue.dark_background.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-blue-onclick.png' => 'a.blue.dark_background.wf_button:active > span, button.blue.dark_background.wf_submit:active span'
    sprite_piece 'buttons/dark_background/btn-blue-onclick-cap.png' => 'a.blue.dark_background.wf_button:active, button.blue.dark_background.wf_submit:active', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-red-default.png' => 'a.red.dark_background.wf_button > span, button.red.dark_background.wf_submit span'
    sprite_piece 'buttons/dark_background/btn-red-default-cap.png' => 'a.red.dark_background.wf_button, button.red.dark_background.wf_submit', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-red-rollover.png' => 'a.red.dark_background.wf_button:hover > span, button.red.dark_background.wf_submit:hover span'
    sprite_piece 'buttons/dark_background/btn-red-rollover-cap.png' => 'a.red.dark_background.wf_button:hover, button.red.dark_background.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-red-onclick.png' => 'a.red.dark_background.wf_button:active > span, button.red.dark_background.wf_submit:active span'
    sprite_piece 'buttons/dark_background/btn-red-onclick-cap.png' => 'a.red.dark_background.wf_button:active, button.red.dark_background.wf_submit:active', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-white-default.png' => 'a.white.dark_background.wf_button > span, button.white.dark_background.wf_submit span'
    sprite_piece 'buttons/dark_background/btn-white-default-cap.png' => 'a.white.dark_background.wf_button, button.white.dark_background.wf_submit', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-white-rollover.png' => 'a.white.dark_background.wf_button:hover > span, button.white.dark_background.wf_submit:hover span'
    sprite_piece 'buttons/dark_background/btn-white-rollover-cap.png' => 'a.white.dark_background.wf_button:hover, button.white.dark_background.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-white-onclick.png' => 'a.white.dark_background.wf_button:active > span, button.white.dark_background.wf_submit:active span'
    sprite_piece 'buttons/dark_background/btn-white-onclick-cap.png' => 'a.white.dark_background.wf_button:active, button.white.dark_background.wf_submit:active', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-green-default.png' => 'a.green.dark_background.wf_button > span, button.green.dark_background.wf_submit span'
    sprite_piece 'buttons/dark_background/btn-green-default-cap.png' => 'a.green.dark_background.wf_button, button.green.dark_background.wf_submit', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-green-rollover.png' => 'a.green.dark_background.wf_button:hover > span, button.green.dark_background.wf_submit:hover span'
    sprite_piece 'buttons/dark_background/btn-green-rollover-cap.png' => 'a.green.dark_background.wf_button:hover, button.green.dark_background.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-green-onclick.png' => 'a.green.dark_background.wf_button:active > span, button.green.dark_background.wf_submit:active span'
    sprite_piece 'buttons/dark_background/btn-green-onclick-cap.png' => 'a.green.dark_background.wf_button:active, button.green.dark_background.wf_submit:active', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-green-default-edge.png' => 'a.right_edge.green.dark_background.wf_button, button.right_edge.green.dark_background.wf_submit', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-green-rollover-edge.png' => 'a.right_edge.green.dark_background.wf_button:hover button.right_edge.green.dark_background.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-green-onclick-edge.png' => 'a.right_edge.green.dark_background.wf_button:active, button.right_edge.green.dark_background.wf_submit:active', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-green-default-drop.png' => 'a.green.dark_background.wf_menu_button'
    sprite_piece 'buttons/dark_background/btn-green-rollover-drop.png' => 'a.green.dark_background.wf_menu_button:hover'
    sprite_piece 'buttons/dark_background/btn-green-onclick-drop.png' => 'a.green.dark_background.wf_menu_button:active'
    sprite_piece 'buttons/dark_background/btn-yellow-default.png' => 'a.yellow.dark_background.wf_button > span, button.yellow.dark_background.wf_submit span'
    sprite_piece 'buttons/dark_background/btn-yellow-default-cap.png' => 'a.yellow.dark_background.wf_button, button.yellow.dark_background.wf_submit', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-yellow-rollover.png' => 'a.yellow.dark_background.wf_button:hover > span, button.yellow.dark_background.wf_submit:hover span'
    sprite_piece 'buttons/dark_background/btn-yellow-rollover-cap.png' => 'a.yellow.dark_background.wf_button:hover, button.yellow.dark_background.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-yellow-onclick.png' => 'a.yellow.dark_background.wf_button:active > span, button.yellow.dark_background.wf_submit:active span'
    sprite_piece 'buttons/dark_background/btn-yellow-onclick-cap.png' => 'a.yellow.dark_background.wf_button:active, button.yellow.dark_background.wf_submit:active', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-black-default-28.png' => 'a.black.dark_background.wf_button > span, button.black.dark_background.wf_submit span'
    sprite_piece 'buttons/dark_background/btn-black-default-cap-28.png' => 'a.black.dark_background.wf_button, button.black.dark_background.wf_submit', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-black-rollover-28.png' => 'a.black.dark_background.wf_button:hover > span, button.black.dark_background.wf_submit:hover span'
    sprite_piece 'buttons/dark_background/btn-black-rollover-cap-28.png' => 'a.black.dark_background.wf_button:hover, button.black.dark_background.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-black-onclick-28.png' => 'a.black.dark_background.wf_button:active > span, button.black.dark_background.wf_submit:active span'
    sprite_piece 'buttons/dark_background/btn-black-onclick-cap-28.png' => 'a.black.dark_background.wf_button:active, button.black.dark_background.wf_submit:active', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-trans-default.png' => 'a.trans.dark_background.wf_button > span, button.trans.dark_background.wf_submit span'
    sprite_piece 'buttons/dark_background/btn-trans-default-cap.png' => 'a.trans.dark_background.wf_button, button.trans.dark_background.wf_submit', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-trans-rollover.png' => 'a.trans.dark_background.wf_button:hover > span, button.trans.dark_background.wf_submit:hover span'
    sprite_piece 'buttons/dark_background/btn-trans-rollover-cap.png' => 'a.trans.dark_background.wf_button:hover, button.trans.dark_background.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-trans-onclick.png' => 'a.trans.dark_background.wf_button:active > span, button.trans.dark_background.wf_submit:active span'
    sprite_piece 'buttons/dark_background/btn-trans-onclick-cap.png' => 'a.trans.dark_background.wf_button:active, button.trans.dark_background.wf_submit:active', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-trans-default-edge.png' => 'a.right_edge.trans.dark_background.wf_button, button.right_edge.trans.dark_background.wf_submit', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-trans-rollover-edge.png' => 'a.right_edge.trans.dark_background.wf_button:hover, button.right_edge.trans.dark_background.wf_submit:hover', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-trans-onclick-edge.png' => 'a.right_edge.trans.dark_background.wf_button:active, button.right_edge.trans.dark_background.wf_submit:active', :x => 'right'
    sprite_piece 'buttons/dark_background/btn-trans-default-drop.png' => 'a.trans.dark_background.wf_menu_button'
    sprite_piece 'buttons/dark_background/btn-trans-rollover-drop.png' => 'a.trans.dark_background.wf_menu_button:hover'
    sprite_piece 'buttons/dark_background/btn-trans-onclick-drop.png' => 'a.trans.dark_background.wf_menu_button:active'
  end
end
