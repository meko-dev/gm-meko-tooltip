tooltip = MekoTooltip();

tooltip.add_content("Lorem ipsum dolor sit amet", { color: c_orange, margin: 16 });
tooltip.add_content("+" + string(floor(random_range(5, 15))) + " strength", { color: c_green });
tooltip.add_content("+" + string(floor(random_range(5, 15))) + " dexterity", { color: c_green, margin: 16 });
tooltip.add_content("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", { color: c_gray });