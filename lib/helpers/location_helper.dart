const GOOGLE_API_KEY = '';  

class LocationHelper {
	static String generateLocationPreviewImage({double latitude, double longitude}) {
		// search for Overview | Maps Static Api // you will finad the given return link here
		return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
	}
}