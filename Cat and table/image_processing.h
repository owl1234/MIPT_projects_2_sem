#include <SFML/Graphics.hpp>

enum Statuses_type {
	ALL_IS_OKEY  	    = 0,
	ESCAPE_PRESSED 	    = 1,
	BAD_POINTERS        = 2,
	TEXTURE_NOT_CREATED = 4,
	BAD_PICTURES_SIZE   = 8,
};

struct Colour {
	unsigned char red;
	unsigned char green;
	unsigned char blue;
	unsigned char alpha;
};

struct Screen_type {
	Colour** pixels;
	int wigth_screen;
	int height_screen;
};

const int count_repeats_in_measurements = 500;
const int max_colour = 255;

Screen_type* screen_new(const char* picture_name);

Statuses_type screen_construct(Screen_type* screen, const char* picture_name);

Statuses_type set_pixel_color(Colour** pixels, const int line, const int column, sf::Color color_now_pixel);

Statuses_type screen_delete(Screen_type* screen);

Statuses_type start_overlaying_pictures(Screen_type* background_picture, Screen_type* foreground_picture);

Statuses_type measurements(Screen_type* background_picture, Screen_type* foreground_picture);

Statuses_type overlaying_pictures(Screen_type* background_picture, Screen_type* foreground_picture);

bool is_correct_pictures_size(Screen_type* background_picture, Screen_type* foreground_picture);

Colour pixel_transform_on_overlay(const Colour background_pixel, const Colour foreground_pixel);

void show_result_image(Screen_type* background_picture, sf::Sprite* sprite, sf::Texture* texture);

void display_picture(sf::Sprite sprite, const int wigth_screen, const int height_screen);
