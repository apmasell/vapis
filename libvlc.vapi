[CCode(cheader_filename = "vlc/libvlc.h,vlc/libvlc_vlm.h")]
namespace VLC {
	/**
	 * Audio channels
	 */
	[CCode(cname = "libvlc_audio_output_channel_t", cheader_filename = "vlc/libvlc_media_player.h")]
	public enum AudioChannel {
		[CCode(cname = "libvlc_AudioChannel_Error")]
		ERROR,
		[CCode(cname = "libvlc_AudioChannel_Stereo")]
		STEREO,
		[CCode(cname = "libvlc_AudioChannel_RStereo")]
		R_STEREO,
		[CCode(cname = "libvlc_AudioChannel_Left")]
		LEFT,
		[CCode(cname = "libvlc_AudioChannel_Right")]
		RIGHT,
		[CCode(cname = "libvlc_AudioChannel_Dolbys")]
		DOLBYS
	}
	/**
	 * Audio device types
	 */
	[CCode(cname = "libvlc_audio_output_device_types_t", cheader_filename = "vlc/libvlc_media_player.h")]
	public enum AudioDevice {
		[CCode(cname = "libvlc_AudioOutputDevice_Error")]
		ERROR,
		[CCode(cname = "libvlc_AudioOutputDevice_Mono")]
		MONO,
		[CCode(cname = "libvlc_AudioOutputDevice_Stereo")]
		STERO,
		[CCode(cname = "libvlc_AudioOutputDevice_2F2R")]
		TWO_F_TWO_R,
		[CCode(cname = "libvlc_AudioOutputDevice_3F2R")]
		THREE_F_TWO_R,
		[CCode(cname = "libvlc_AudioOutputDevice_5_1")]
		FIVE_ONE,
		[CCode(cname = "libvlc_AudioOutputDevice_6_1")]
		SIX_ONE,
		[CCode(cname = "libvlc_AudioOutputDevice_7_1")]
		SEVEN_ONE,
		[CCode(cname = "libvlc_AudioOutputDevice_SPDIF")]
		SPDIF
	}
	/**
	 * Event types
	 */
	[CCode(cname = "enum libvlc_event_e", cprefix = "libvlc_", cheader_filename = "vlc/libvlc_events.h")]
	public enum EventType {
		[CCode(cname = "libvlc_MediaMetaChanged")]
		MEDIA_META_CHANGED,
		[CCode(cname = "libvlc_MediaSubItemAdded")]
		MEDIA_SUB_ITEM_ADDED,
		[CCode(cname = "libvlc_MediaDurationChanged")]
		MEDIA_DURATION_CHANGED,
		[CCode(cname = "libvlc_MediaParsedChanged")]
		MEDIA_PARSED_CHANGED,
		[CCode(cname = "libvlc_MediaFreed")]
		MEDIA_FREED,
		[CCode(cname = "libvlc_MediaStateChanged")]
		MEDIA_STATE_CHANGED,
		[CCode(cname = "libvlc_MediaPlayerMediaChanged")]
		MEDIA_PLAYER_MEDIA_CHANGED,
		[CCode(cname = "libvlc_MediaPlayerNothingSpecial")]
		MEDIA_PLAYER_NOTHING_SPECIAL,
		[CCode(cname = "libvlc_MediaPlayerOpening")]
		MEDIA_PLAYER_OPENING,
		[CCode(cname = "libvlc_MediaPlayerBuffering")]
		MEDIA_PLAYER_BUFFERING,
		[CCode(cname = "libvlc_MediaPlayerPlaying")]
		MEDIA_PLAYER_PLAYING,
		[CCode(cname = "libvlc_MediaPlayerPaused")]
		MEDIA_PLAYER_PAUSED,
		[CCode(cname = "libvlc_MediaPlayerStopped")]
		MEDIA_PLAYER_STOPPED,
		[CCode(cname = "libvlc_MediaPlayerForward")]
		MEDIA_PLAYER_FORWARD,
		[CCode(cname = "libvlc_MediaPlayerBackward")]
		MEDIA_PLAYER_BACKWARD,
		[CCode(cname = "libvlc_MediaPlayerEndReached")]
		MEDIA_PLAYER_END_REACHED,
		[CCode(cname = "libvlc_MediaPlayerEncounteredError")]
		MEDIA_PLAYER_ENCOUNTERED_ERROR,
		[CCode(cname = "libvlc_MediaPlayerTimeChanged")]
		MEDIA_PLAYER_TIME_CHANGED,
		[CCode(cname = "libvlc_MediaPlayerPositionChanged")]
		MEDIA_PLAYER_POSITION_CHANGED,
		[CCode(cname = "libvlc_MediaPlayerSeekableChanged")]
		MEDIA_PLAYER_SEEKABLE_CHANGED,
		[CCode(cname = "libvlc_MediaPlayerPausableChanged")]
		MEDIA_PLAYER_PAUSABLE_CHANGED,
		[CCode(cname = "libvlc_MediaPlayerTitleChanged")]
		MEDIA_PLAYER_TITLE_CHANGED,
		[CCode(cname = "libvlc_MediaPlayerSnapshotTaken")]
		MEDIA_PLAYER_SNAPSHOT_TAKEN,
		[CCode(cname = "libvlc_MediaPlayerLengthChanged")]
		MEDIA_PLAYER_LENGTH_CHANGED,
		[CCode(cname = "libvlc_MediaListItemAdded")]
		MEDIA_LIST_ITEM_ADDED,
		[CCode(cname = "libvlc_MediaListWillAddItem")]
		MEDIA_LIST_WILL_ADD_ITEM,
		[CCode(cname = "libvlc_MediaListItemDeleted")]
		MEDIA_LIST_ITEM_DELETED,
		[CCode(cname = "libvlc_MediaListWillDeleteItem")]
		MEDIA_LIST_WILL_DELETE_ITEM,
		[CCode(cname = "libvlc_MediaListViewItemAdded")]
		MEDIA_LIST_VIEW_ITEM_ADDED,
		[CCode(cname = "libvlc_MediaListViewWillAddItem")]
		MEDIA_LIST_VIEW_WILL_ADD_ITEM,
		[CCode(cname = "libvlc_MediaListViewItemDeleted")]
		MEDIA_LIST_VIEW_ITEM_DELETED,
		[CCode(cname = "libvlc_MediaListViewWillDeleteItem")]
		MEDIA_LIST_VIEW_WILL_DELETE_ITEM,
		[CCode(cname = "libvlc_MediaListPlayerPlayed")]
		MEDIA_LIST_PLAYER_PLAYED,
		[CCode(cname = "libvlc_MediaListPlayerNextItemSet")]
		MEDIA_LIST_PLAYER_NEXT_ITEM_SET,
		[CCode(cname = "libvlc_MediaListPlayerStopped")]
		MEDIA_LIST_PLAYER_STOPPED,
		[CCode(cname = "libvlc_MediaDiscovererStarted")]
		MEDIA_DISCOVERER_STARTED,
		[CCode(cname = "libvlc_MediaDiscovererEnded")]
		MEDIA_DISCOVERER_ENDED,
		[CCode(cname = "libvlc_VlmMediaAdded")]
		VLM_MEDIA_ADDED,
		[CCode(cname = "libvlc_VlmMediaRemoved")]
		VLM_MEDIA_REMOVED,
		[CCode(cname = "libvlc_VlmMediaChanged")]
		VLM_MEDIA_CHANGED,
		[CCode(cname = "libvlc_VlmMediaInstanceStarted")]
		VLM_MEDIA_INSTANCE_STARTED,
		[CCode(cname = "libvlc_VlmMediaInstanceStopped")]
		VLM_MEDIA_INSTANCE_STOPPED,
		[CCode(cname = "libvlc_VlmMediaInstanceStatusInit")]
		VLM_MEDIA_INSTANCE_STATUS_INIT,
		[CCode(cname = "libvlc_VlmMediaInstanceStatusOpening")]
		VLM_MEDIA_INSTANCE_STATUS_OPENING,
		[CCode(cname = "libvlc_VlmMediaInstanceStatusPlaying")]
		VLM_MEDIA_INSTANCE_STATUS_PLAYING,
		[CCode(cname = "libvlc_VlmMediaInstanceStatusPause")]
		VLM_MEDIA_INSTANCE_STATUS_PAUSE,
		[CCode(cname = "libvlc_VlmMediaInstanceStatusEnd")]
		VLM_MEDIA_INSTANCE_STATUS_END,
		[CCode(cname = "libvlc_VlmMediaInstanceStatusError")]
		VLM_MEDIA_INSTANCE_STATUS_ERROR
	}
	/**
	 * Metadata types
	 */
	[CCode(cname = "libvlc_meta_t", cheader_filename = "vlc/libvlc_media.h")]
	public enum Meta {
		[CCode(cname = "libvlc_meta_Title")]
		TITLE,
		[CCode(cname = "libvlc_meta_Artist")]
		ARTIST,
		[CCode(cname = "libvlc_meta_Genre")]
		GENRE,
		[CCode(cname = "libvlc_meta_Copyright")]
		COPYRIGHT,
		[CCode(cname = "libvlc_meta_Album")]
		ALBUM,
		[CCode(cname = "libvlc_meta_TrackNumber")]
		TRACK_NUMBER,
		[CCode(cname = "libvlc_meta_Description")]
		DESCRIPTION,
		[CCode(cname = "libvlc_meta_Rating")]
		RATING,
		[CCode(cname = "libvlc_meta_Date")]
		DATE,
		[CCode(cname = "libvlc_meta_Setting")]
		SETTING,
		[CCode(cname = "libvlc_meta_URL")]
		URL,
		[CCode(cname = "libvlc_meta_Language")]
		LANGUAGE,
		[CCode(cname = "libvlc_meta_NowPlaying")]
		NOW_PLAYING,
		[CCode(cname = "libvlc_meta_Publisher")]
		PUBLISHER,
		[CCode(cname = "libvlc_meta_EncodedBy")]
		ENCODED_BY,
		[CCode(cname = "libvlc_meta_ArtworkURL")]
		ARTWORK_URL,
		[CCode(cname = "libvlc_meta_TrackID")]
		TRACK_ID
	}
	[CCode(cname = "int", cheader_filename = "vlc/libvlc_media.h")]
	[Flags]
	public enum Option {
		[CCode(cname = "libvlc_media_option_trusted")]
		TRUSTED,
		[CCode(cname = "libvlc_media_option_unique")]
		UNIQUE
	}
	/**
	 * Playback modes for playlist.
	 */
	[CCode(cname = "libvlc_playback_mode_t", cheader_filename = "vlc/libvlc_media_list_player.h")]
	public enum PlaybackMode {
		[CCode(cname = "libvlc_playback_mode_default")]
		DEFAULT,
		[CCode(cname = "libvlc_playback_mode_loop")]
		LOOP,
		[CCode(cname = "libvlc_playback_mode_repeat")]
		REPEAT
	}
	[CCode(cname = "libvlc_state_t", cheader_filename = "vlc/libvlc_media.h")]
	public enum State {
		[CCode(cname = "libvlc_NothingSpecial")]
		NOTHING_SPECIAL,
		[CCode(cname = "libvlc_Opening")]
		OPENING,
		[CCode(cname = "libvlc_Buffering")]
		BUFFERING,
		[CCode(cname = "libvlc_Playing")]
		PLAYING,
		[CCode(cname = "libvlc_Paused")]
		PAUSED,
		[CCode(cname = "libvlc_Stopped")]
		STOPPED,
		[CCode(cname = "libvlc_Ended")]
		ENDED,
		[CCode(cname = "libvlc_Error")]
		ERROR
	}
	[CCode(cname = "libvlc_track_type_t", cheader_filename = "vlc/libvlc_media.h")]
	public enum TrackType {
		[CCode(cname = "libvlc_track_unknown")]
		UNKNOWN,
		[CCode(cname = "libvlc_track_audio")]
		AUDIO,
		[CCode(cname = "libvlc_track_video")]
		VIDEO,
		[CCode(cname = "libvlc_track_text")]
		TEXT
	}
	[CCode(cname = "libvlc_audio_output_t", free_function = "libvlc_audio_output_list_release")]
	[Compact]
	public class AudioList {
		public audio_output? get(int i) {
			return ((audio_output[])this)[i];
		}
	}
	/**
	 * Media discovery
	 *
	 * LibVLC media discovery finds available media via various means.
	 * This corresponds to the service discovery functionality in VLC media player.
	 * Different plugins find potential medias locally (e.g. user media directory),
	 * from peripherals (e.g. video capture device), on the local network
	 * (e.g. SAP) or on the Internet (e.g. Internet radios).
	 */
	[CCode(cname = "libvlc_media_discoverer_t", free_function = "libvlc_media_discoverer_release", cheader_filename = "vlc/libvlc_media_discoverer.h")]
	[Compact]
	public class Discoverer<T> {
		public EventManager event_manager {
				[CCode(cname = "libvlc_media_discoverer_event_manager")]
				get;
		}
		/**
		 * Query if media service discover object is running.
		 */
		public bool is_running {
			[CCode(cname = "libvlc_media_discoverer_is_running")]
			get;
		}
		/**
		 * Media service discover object's localized name.
		 */
		public string localized_name {
			[CCode(cname = "libvlc_media_discoverer_localized_name")]
			get;
		}
		/**
		 * Get media service discover media list.
		 */
		public MediaList<T> media_list {
			[CCode(cname = "libvlc_media_discoverer_media_list", simple_generics = true)]
			get;
		}
	}
	[CCode(cname = "libvlc_event_manager_t")]
	[Compact]
	public class EventManager {
	}
	[CCode(cname = "libvlc_instance_t", unref_function = "libvlc_release", ref_function = "libvlc_retain")]
	public class Instance {
		public EventManager event_manager {
			[CCode(cname = "libvlc_vlm_get_event_manager")]
			get;
		}
		/**
		 * Create and initialize a libvlc instance.
		 *
		 * This functions accept a list of "command line" arguments similar to the
		 * main(). These arguments affect the LibVLC instance default
		 * configuration.
		 *
		 * Arguments are meant to be passed from the command line to LibVLC, just
		 * like VLC media player does. The list of valid arguments depends on the
		 * LibVLC version, the operating system and platform, and set of available
		 * LibVLC plugins. Invalid or unsupported arguments will cause the function
		 * to fail. Also, some arguments may alter the behaviour or otherwise
		 * interfere with other LibVLC functions.
		 *
		 * There is absolutely no warranty or promise of forward, backward and
		 * cross-platform compatibility with regards to arguments. We recommend
		 * that you do not use them, other than when debugging.
		 */
		[CCode(cname = "libvlc_new")]
		public static Instance? create([CCode(array_length_pos = 0.1)] string[]? args = null);
		/**
		 * Add a broadcast, with one input.
		 *
		 * @param name the name of the new broadcast
		 * @param input the input MRL
		 * @param output the output MRL (the parameter to the "sout" variable)
		 * @param options additional options
		 * @param enabled boolean for enabling the new broadcast
		 * @param loop Should this broadcast be played in loop ?
		 * @return false on success, true on error
		 */
		[CCode(cname = "libvlc_vlm_add_broadcast")]
		public bool add_broadcast(string name, string input, string output, [CCode(array_length_pos = 3.1)] string[] options, bool enabled, bool loop);
		/**
		 * Add a media's input MRL. This will add the specified one.
		 *
		 * @param name the media to work on
		 * @param input the input MRL
		 * @return false on success, true on error
		 */
		[CCode(cname = "libvlc_vlm_add_input")]
		public bool add_input(string name, string input);
		/**
		 * Add a vod, with one input.
		 *
		 * @param name the name of the new vod media
		 * @param input the input MRL
		 * @param options additional options
		 * @param enabled boolean for enabling the new vod
		 * @param mux the muxer of the vod media
		 * @return false on success, true on error
		 */
		[CCode(cname = "libvlc_vlm_add_vod")]
		public bool add_vod(string name, string input, [CCode(array_length_pos = 2.1)] string[] options, bool enabled, string mux);
		/**
		 * Edit the parameters of a media. This will delete all existing inputs and
		 * add the specified one.
		 *
		 * @param name the name of the new broadcast
		 * @param input the input MRL
		 * @param output the output MRL (the parameter to the "sout" variable)
		 * @param options additional options
		 * @param enabled enable the new broadcast
		 * @param loop Should this broadcast be played in loop ?
		 * @return false on success, true on error
		 */
		[CCode(cname = "libvlc_vlm_change_media")]
		public bool change_media(string name, string input, string output, [CCode(array_length_pos = 3.1)] string[] options, bool enabled, bool loop);
		/**
		 * Create new media list player.
		 *
		 * @return media list player instance or null on error
		 */
		[CCode(cname = "libvlc_media_list_player_new", simple_generics = true)]
		public ListPlayer<T>? create_list_player<T>();
		/**
		 * Create an empty media list.
		 * @return empty media list, or null on error
		 */
		[CCode(cname = "libvlc_media_list_new", simple_generics = true)]
		public MediaList<T>? create_media_list<T>();
		/**
		 * Create an empty Media Player object
		 */
		[CCode(cname = "libvlc_media_player_new", simple_generics = true)]
		public Player<T>? create_player<T>();
		/**
		 * Get count of devices for audio output, these devices are hardware oriented
		 * like analog or digital output of sound card
		 *
		 * @param audio_output name of audio output
		 * @return number of devices
		 * @see audio_output
		 */
		[CCode(cname = "libvlc_audio_output_device_count")]
		public int get_audio_device_count(string audio_output);
		/**
		 * Get id name of device
		 *
		 * @param audio_output name of audio output, {@link audio_output}
		 * @param device device index
		 * @return id name of device, use for setting device, need to be free after use
		 */
		[CCode(cname = "libvlc_audio_output_device_id")]
		public unowned string get_audio_device_id(string audio_output, int device);
		/**
		 * Get long name of device, if not available short name given
		 *
		 * @param audio_output name of audio output, {@link audio_output}
		 * @param device device index
		 * @return long name of device
		 */
		[CCode(cname = "libvlc_audio_output_device_longname")]
		public unowned string get_audio_device_name(string audio_output, int device);
		/**
		 * Get the list of available audio outputs
		 *
		 * @return list of available audio outputs. In case of error, null is returned.
		 */
		[CCode(cname = "libvlc_audio_output_list_get")]
		public AudioList? get_audio_output_list();
		/**
		 * Discover media service by name.
		 *
		 * @param name service name
		 * @return media discover object or null in case of error
		 */
		[CCode(cname = "libvlc_media_discoverer_new_from_name", simple_generics = true)]
		public Discoverer<T>? get_discoverer_from_name<T>(string name);
		/**
		 * Get media instance length by name or instance id
		 *
		 * @param name name of vlm media instance
		 * @param instance instance id
		 * @return length of media item or -1 on error
		 */
		[CCode(cname = "libvlc_vlm_get_media_instance_length")]
		public int get_media_instance_length(string name, int instance);
		/**
		* Get media instance position by name or instance id
		*
		* @param name name of vlm media instance
		* @param instance instance id
		* @return position as float or -1 on error
		*/
		[CCode(cname = "libvlc_vlm_get_media_instance_position")]
		public float get_media_instance_position(string name, int instance);
		/**
		 * Get media instance time by name or instance id
		 *
		 * @param name name of vlm media instance
		 * @param instance instance id
		 * @return time as integer or -1 on error
		 */
		[CCode(cname = "libvlc_vlm_get_media_instance_time")]
		public int get_media_instance_time(string name, int instance);
		/**
		 * Get media instance playback rate by name or instance id
		 *
		 * @param name name of vlm media instance
		 * @param instance instance id
		 * @return playback rate or -1 on error
		 */
		[CCode(cname = "libvlc_vlm_get_media_instance_rate")]
		public int get_media_instance_rate(string name, int instance);
		/**
		 * Create a media for an already open file descriptor.
		 * The file descriptor shall be open for reading (or reading and writing).
		 *
		 * Regular file descriptors, pipe read descriptors and character device
		 * descriptors (including TTYs) are supported on all platforms.
		 * Block device descriptors are supported where available.
		 * Directory descriptors are supported on systems that provide fdopendir().
		 * Sockets are supported on all platforms where they are file descriptors,
		 * i.e. all except Windows.
		 *
		 * This library will <b>not</b> automatically close the file descriptor
		 * under any circumstance. Nevertheless, a file descriptor can usually only be
		 * rendered once in a media player. To render it a second time, the file
		 * descriptor should probably be rewound to the beginning with lseek().
		 *
		 * @param fd open file descriptor
		 * @return the newly created media or null on error
		 */
		[CCode(cname = "libvlc_media_new_fd", simple_generics = true)]
		public Media<S>? open_media_fd<S>(int fd);
		/**
		 * Create a media with a certain given media resource location,
		 * for instance a valid URL.
		 *
		 * To refer to a local file with this function, the file: URI syntax
		 * '''must'''> be used (see IETF RFC3986). We recommend using
		 * {@link open_media_path} instead when dealing with local files.
		 *
		 * @param mrl the media location
		 * @return the newly created media or null on error
		 */
		[CCode(cname = "libvlc_media_new_location", simple_generics = true)]
		public Media<S>? open_media_location<S>(string mrl);
		/**
		 * Create a media as an empty node with a given name.
		 *
		 * @param name the name of the node
		 * @return the new empty media or null on error
		 */
		[CCode(cname = "libvlc_media_new_as_node", simple_generics = true)]
		public Media<S>? open_media_node<S>(string name);
		/**
		 * Create a media for a certain file path.
		 *
		 * @param path local filesystem path
		 * @return the newly created media or null on error
		 */
		[CCode(cname = "libvlc_media_new_path", simple_generics = true)]
		public Media<S>? open_media_path<S>(string path);
		/**
		 * Pause the named broadcast.
		 *
		 * @param name the name of the broadcast
		 * @return false on success, true on error
		 */
		[CCode(cname = "libvlc_vlm_pause_media")]
		public bool pause_media(string name);
		/**
		 * Play the named broadcast.
		 *
		 * @param name the name of the broadcast
		 * @return false on success, true on error
		 */
		[CCode(cname = "libvlc_vlm_play_media")]
		public bool play_media (string name);
		/**
		 * Start playing (if there is any item in the playlist).
		 *
		 * Additionnal playlist item options can be specified for addition to the
		 * item before it is played.
		 *
		 * @param id the item to play. If this is a negative number, the next item
		 * will be selected. Otherwise, the item with the given ID will be played
		 * @param options the options to add to the item
		 */
		[Deprecated]
		[CCode(cname = "libvlc_playlist_play")]
		public void play_playlist(int id, [CCode(array_length_pos = 1.1)] string[] options);
		[CCode(cname = "libvlc_retain")]
		public void ref();
		/**
		 * Release the vlm instance
		 */
		[CCode(cname = "libvlc_vlm_release")]
		public void release_vlm();
		/**
		 * Delete a media (VOD or broadcast).
		 *
		 * @param name the media to delete
		 * @return false on success, true on error
		 */
		[CCode(cname = "libvlc_vlm_del_media")]
		public bool remove_media(string name);
		/**
		 * Seek in the named broadcast.
		 *
		 * @param name the name of the broadcast
		 * @return false on success, true on error
		 */
		[CCode(cname = "libvlc_vlm_seek_media")]
		public bool seek_media(string name, float percentage);
		/**
		 * Enable or disable a media (VOD or broadcast).
		 *
		 * @param name the media to work on
		 * @param enabled the new status
		 * @return false on success, true on error
		 */
		[CCode(cname = "libvlc_vlm_set_enabled")]
		public bool set_enabled(string name, bool enabled);
		/**
		 * Set a media's input MRL. This will delete all existing inputs and
		 * add the specified one.
		 *
		 * @param name the media to work on
		 * @param input the input MRL
		 * @return false on success, true on error
		 */
		[CCode(cname = "libvlc_vlm_set_input")]
		public bool set_input(string name, string input);
		/**
		 * Set a media's loop status.
		 *
		 * @param p_instance the instance
		 * @param name the media to work on
		 * @param b_loop the new status
		 * @return false on success, true on error
		 */
		[CCode(cname = "libvlc_vlm_set_loop")]
		public bool set_loop(string name, bool loop);
		/**
		 * Set a media's vod muxer.
		 *
		 * @param p_instance the instance
		 * @param name the media to work on
		 * @param mux the new muxer
		 * @return false on success, true on error
		 */
		[CCode(cname = "libvlc_vlm_set_mux")]
		public bool set_mux(string name, string mux);
		/**
		 * Set the output for a media.
		 *
		 * @param name the media to work on
		 * @param output the output MRL (the parameter to the "sout" variable)
		 * @return false on success, true on error
		 */
		[CCode(cname = "libvlc_vlm_set_output")]
		public bool set_output(string name, string output);
		/**
		 * Return information about the named media as a JSON
		 * string representation.
		 *
		 * This function is mainly intended for debugging use,
		 * if you want programmatic access to the state of
		 * an instance, please use the corresponding
		 * {@link get_media_instance_length} and friends.
		 *
		 * @param name the name of the media, if the name is an empty string, all media is described
		 * @return string with information about named media, or null on error
		 */
		[CCode(cname = "libvlc_vlm_show_media")]
		public unowned string? show_media(string name);
		/**
		 * Stop the named broadcast.
		 *
		 * @param name the name of the broadcast
		 * @return false on success, true on error
		 */
		[CCode(cname = "libvlc_vlm_stop_media")]
		public bool stop_media (string name);
		[CCode(cname = "libvlc_release")]
		public void unref();
	}
	/**
	* Plays a list of media, in a certain order.
	*
	* This is required to especially support playlist files.
	* The normal {@link Player} can only play a single media, and does not
	* handle playlist files properly.
	*/
	[CCode(cname = "libvlc_media_list_player_t", free_function = "libvlc_media_list_player_release", cheader_filename = "vlc/libvlc_media_list_player.h")]
	[Compact]
	public class ListPlayer<T> {
		/**
		 * The event manager.
		 */
		public EventManager event_manager {
			[CCode(cname = "libvlc_media_list_player_event_manager")]
			get;
		}
		/**
		 * The media list associated with the player
		 */
		public MediaList<T> list {
			[CCode(cname = "libvlc_media_list_player_set_media_list", simple_generics = true)]
			get;
		}
		/**
		 * The playback mode for the playlist
		 */
		public PlaybackMode mode {
			[CCode(cname = "libvlc_media_list_player_set_playback_mode")]
			set;
		}
		/**
		 * The media player.
		 */
		public Player<T>? player {
			[CCode(cname = "libvlc_media_list_player_set_media_player", simple_generics = true)]
			set;
		}
		/**
		 * The current state of media list player
		 */
		public State state {
			[CCode(cname = "libvlc_media_list_player_get_state")]
			get;
		}
		/**
		 * Play next item from media list
		 *
		 * @return false upon success, true if there is no next item
		 */
		[CCode(cname = "libvlc_media_list_player_next")]
		public bool next();
		/**
		 * Pause media list
		 */
		[CCode(cname = "libvlc_media_list_player_pause")]
		public void pause();
		/**
		 * Play media list
		 */
		[CCode(cname = "libvlc_media_list_player_play")]
		public void play();
		/**
		 * Play the given media item
		 *
		 * @param md the media instance
		 * @return false upon success, true if the item was not found.
		 */
		[CCode(cname = "libvlc_media_list_player_play_item", simple_generics = true)]
		public bool play_item(Media<T> md);
		/**
		 * Play media list item at position index
		 *
		 * @param index index in media list to play
		 * @return false upon success, true if the item was not found.
		 */
		[CCode(cname = "libvlc_media_list_player_play_item_at_index")]
		public bool play_item_at_index(int index);
		/**
		 * Play previous item from media list
		 *
		 * @return false upon success, true if there is no previous item
		 */
		[CCode(cname = "libvlc_media_list_player_previous")]
		public bool previous();
		/**
		 * Stop playing media list
		 */
		[CCode(cname = "libvlc_media_list_player_stop")]
		public void stop();
	}
	[CCode(cname = "libvlc_log_t")]
	[Compact]
	public class Log {
		[CCode(cname = "int", has_type_id = false)]
		public enum Severity {
			[CCode(cname = "0")]
			INFO,
			[CCode(cname = "1")]
			ERR,
			[CCode(cname = "2")]
			WARN,
			[CCode(cname = "3")]
			DBG
		}
		/**
		 * Optional header
		 */
		[CCode(cname = "header")]
		public string? header;
		/**
		 * Message
		 */
		[CCode(cname = "message")]
		public string message;
		/**
		 * Module name
		 */
		[CCode(cname = "name")]
		public string name;
		[CCode(cname = "i_severity")]
		public Severity severity;
		/**
		 * sizeof() of message structure, must be filled in by user
		 */
		[CCode(cname = "sizeof_msg")]
		public uint sizeof_msg;
		/**
		 * Module type
		 */
		[CCode(cname = "type")]
		public string type;
	}
	/**
	 * Abstract representation of a playable media.
	 *
	 * It consists of a media location and various optional meta data.
	 */
	[CCode(cname = "libvlc_media_t", ref_function = "libvlc_media_retain", unref_function = "libvlc_media_release", cheader_filename = "vlc/libvlc_media.h")]
	public class Media<T> {
		/**
		 * Get duration (in ms) of media descriptor object item.
		 */
		public int64 duration {
		 [CCode(cname = "libvlc_media_get_duration")]
		 get;
		}
		/**
		 * Get event manager from media descriptor object.
		 */
		public EventManager event_manager {
			[CCode(cname = "libvlc_media_event_manager")]
			get;
		}
		/**
		 * Parsed status for media descriptor object.
		 *
		 * @see EventType.MEDIA_PARSED_CHANGED
		 */
		public bool is_parsed {
			[CCode(cname = "libvlc_media_is_parsed")]
			get;
		}
		/**
		 * The media resource locator (mrl)
		 */
		public string mrl {
			[CCode(cname = "libvlc_media_get_mrl")]
			get;
		}
		/**
		 * Current state of media descriptor object.
		 */
		public State state {
			[CCode(cname = "libvlc_media_get_state")]
			get;
		}
		/**
		 * Data accessed by the host application, VLC.framework uses it as a pointer to
		 * an native object
		 */
		public T user_data {
			[CCode(cname = "libvlc_media_set_user_data", simple_generics = true)]
			set;
			[CCode(cname = "libvlc_media_get_user_data", simple_generics = true)]
			get;
		}
		/**
		 * Add an option to the media.
		 *
		 * This option will be used to determine how the media_player will
		 * read the media. This allows to use VLC's advanced
		 * reading/streaming options on a per-media basis.
		 *
		 * The options are detailed in vlc ''--long-help'', for instance ''--sout-all''
		 *
		 * @param options the options (as a string)
		 */
		[CCode(cname = "libvlc_media_add_option")]
		public void add_option(string options);
		/**
		 * Add an option to the media with configurable flags.
		 *
		 * This option will be used to determine how the media_player will
		 * read the media. This allows to use VLC's advanced
		 * reading/streaming options on a per-media basis.
		 *
		 * The options are detailed in vlc --long-help, for instance ''--sout-all''
		 *
		 * @param options the options (as a string)
		 * @param i_flags the flags for this option
		 */
		[CCode(cname = "libvlc_media_add_option_flag")]
		public void add_option_flag(string options, Option flags = 0);
		/**
		 * Create a Media Player object from a Media
		 */
		[CCode(cname = "libvlc_media_player_new_from_media")]
		public Player<T>? create_player();
		/**
		 * Duplicate a media descriptor object.
		 */
		[CCode(cname = "libvlc_media_duplicate", simple_generics = true)]
		public Media<T> duplicate();
		/**
		 * Read the meta of the media.
		 *
		 * If the media has not yet been parsed this will return NULL.
		 *
		 * This methods automatically calls libvlc_media_parse_async(), so after
		 * calling it you may receive a {@link EventType.MEDIA_META_CHANGED} event.
		 * If you prefer a synchronous version ensure that you call
		 * {@link parse} before.
		 *
		 * @see parse
		 * @see parse_async
		 *
		 * @param meta the meta to read
		 * @return the media's meta
		 */
		[CCode(cname = "libvlc_media_get_meta")]
		public string? get(Meta meta);
		/**
		 * Get the current statistics about the media
		 : @param p_stats structure that contain the statistics about the media
		 * @return true if the statistics are available, false otherwise
		 */
		[CCode(cname = "libvlc_media_get_stats")]
		public bool get_stats(out media_stats p_stats);
		/**
		 * Get media descriptor's elementary streams description
		 *
		 * Note, you need to play the media ''one'' time with --sout="#description"
		 * Not doing this will result in an empty array, and doing it more than once
		 * will duplicate the entries in the array each time. Something like this:
		 *
		 * {{{
		 * var player = media.create_player();
		 * media.add_option_flag("sout=#description");
		 * player.play();
		 * }}}
		 *
		 * This is very likely to change in next release, and be done at the parsing
		 * phase.
		 */
		public track_info[] get_tracks_info() {
			track_info[] info;
			info.length = _get_tracks_info(out info);
			return info;
		}
		[CCode(cname = "libvlc_media_get_tracks_info")]
		private int _get_tracks_info(out track_info[] info);
		/**
		 * Parse a media.
		 *
		 * This fetches (local) meta data and tracks information.
		 * The method is synchronous.
		 *
		 * @see parse_async
		 * @see get
		 * @see get_tracks_info
		 */
		[CCode(cname = "libvlc_media_parse")]
		public void parse();
		/**
		 * Parse a media.
		 *
		 * This fetches (local) meta data and tracks information.
		 * The method is the asynchronous of {@link parse}.
		 *
		 * To track when this is over you can listen to {@link EventType.MEDIA_PARSED_CHANGED}
		 * event. However if the media was already parsed you will not receive this
		 * event.
		 *
		 * @see parse
		 * @see get
		 * @see get_tracks_info
		 */
		[CCode(cname = "libvlc_media_parse_async")]
		public void parse_async();
		/**
		 * Retain a reference to a media descriptor object. Use
		 * {@link unref} to decrement the reference count of a
		 * media descriptor object.
		 */
		[CCode(cname = "libvlc_media_retain")]
		public void ref();
		/**
		 * Save the meta previously set
		 *
		 * @return true if the write operation was successfull
		 */
		[CCode(cname = "libvlc_media_save_meta")]
		public bool save_meta();
		/**
		 * Set the meta of the media (this function will not save the meta, call
		 * {@link save_meta} in order to save the meta)
		 *
		 * @param meta the meta to write
		 * @param value the media's meta
		 */
		[CCode(cname = "libvlc_media_set_meta")]
		public void set(Meta meta, string value);
		/**
		 * Decrement the reference count of a media descriptor object. If the
		 * reference count is 0, then this method will release the media descriptor
		 * object. It will send out an {@link EventType.MEDIA_FREED} event to all
		 * listeners. If the media descriptor object has been released it should
		 * not be used again.
		 */
		[CCode(cname = "libvlc_media_release")]
		public void unref();
	}
	/**
	 * Holds multiple {@link Media} descriptors.
	 */
	[CCode(cname = "libvlc_media_list_t", unref_function = "libvlc_media_list_release", ref_function = "libvlc_media_list_retain", cheader_filename = "vlc/libvlc_media_list.h")]
	public class MediaList<T> {
		/**
		 * The event manager from this media list instance.
		 *
		 * The event manager is immutable, so you don't have to hold the lock
		 */
		public EventManager event_manager {
			[CCode(cname = "libvlc_media_list_event_manager")]
			get;
		}
		/**
		 * Is media list playing?
		 */
		public bool is_playing {
			[CCode(cname = "libvlc_media_list_player_is_playing")]
			get;
		}
		/**
		 * This indicates if this media list is read-only from a user point of view
		 */
		public bool is_writable {
			[CCode(cname = "libvlc_media_list_is_readonly")]
			get;
		}
		/**
		 * The number of items in media list
		 *
		 * The {@link lock} should be held upon entering this function.
		 */
		public int length {
			[CCode(cname = "libvlc_media_list_count")]
			get;
		}
		/**
		 * The associated media instance with this media list instance.
		 *
		 * The {@link lock} should NOT be held upon entering this function.
		 */
		public Media<T> media {
			[CCode(cname = "libvlc_media_list_set_media", simple_generics = true)]
			set;
			[CCode(cname = "libvlc_media_list_media", simple_generics = true)]
			owned get;
		}
		[CCode(cname = "libvlc_media_list_add_file_content")]
		[Deprecated]
		public int add_file_content(string uri);
		/**
		 * Add media instance to media list
		 *
		 * The {@link lock} should be held upon entering this function.
		 *
		 * @param md a media instance
		 * @return false on success
		 */
		[CCode(cname = "libvlc_media_list_add_media", simple_generics = true)]
		public bool add_media(Media<T> md);
		/**
		 * List media instance in media list at a position
		 *
		 * The {@link lock} should be held upon entering this function.
		 *
		 * @param pos position in array
		 * @return media instance at position pos, or null if not found.
		 */
		[CCode(cname = "libvlc_media_list_item_at_index", simple_generics = true)]
		public Media<T>? get(int pos);
		/**
		 * Find index position of List media instance in media list.
		 *
		 * The function will return the first matched position.
		 *
		 * The {@link lock} should be held upon entering this function.
		 * @param md media list instance
		 * @return position of media instance
		 */
		[CCode(cname = "libvlc_media_list_index_of_item", simple_generics = true)]
		public int index_of_item(Media<T> md);
		/**
		 * Insert media instance in media list on a position
		 *
		 * The {@link lock} should be held upon entering this function.
		 * @param md a media instance
		 * @param pos position in array where to insert
		 * @return false on success
		 */
		[CCode(cname = "libvlc_media_list_insert_media", simple_generics = true)]
		public bool insert_media(Media<T> md, int pos);
		/**
		 * Get lock on media list items
		 */
		[CCode(cname = "libvlc_media_list_lock")]
		public void lock();
		/**
		 * Retain reference to a media list.
		 */
		[CCode(cname = "libvlc_media_list_retain")]
		public void ref();
		/**
		 * Remove media instance from media list on a position
		 *
		 * The {@link lock} should be held upon entering this function.
		 * @param pos position in array where to insert
		 * @return false on success, true if the list is read-only or the item was not found
		 */
		[CCode(cname = "libvlc_media_list_remove_index")]
		public bool remove_index(int pos);
		/**
		 * Release lock on media list items
		 *
		 * The lock should be held upon entering this function.
		 */
		[CCode(cname = "libvlc_media_list_unlock")]
		public void unlock();
		/**
		 * Release media list.
		 */
		[CCode(cname = "libvlc_media_list_release")]
		public void unref();
	}
	/**
	 * Plays one media (usually in a custom drawable).
	 */
	[CCode(cname = "libvlc_media_player_t", unref_function = "libvlc_media_player_release", ref_function = "libvlc_media_player_retain", cheader_filename = "vlc/libvlc_media_player.h")]
	public class Player<T> {
		[CCode(cname = "libvlc_video_logo_option_t")]
		public enum LogoOption {
			[CCode(cname = "libvlc_logo_enable")]
			ENABLE,
			/**
			 * string argument, "file,d,t;file,d,t;..."
			 */
			[CCode(cname = "libvlc_logo_file")]
			FILE,
			[CCode(cname = "libvlc_logo_x")]
			X,
			[CCode(cname = "libvlc_logo_y")]
			Y,
			[CCode(cname = "libvlc_logo_delay")]
			DELAY,
			[CCode(cname = "libvlc_logo_repeat")]
			REPEAT,
			[CCode(cname = "libvlc_logo_opacity")]
			OPACITY,
			[CCode(cname = "libvlc_logo_position")]
			POSITION
		}
		/**
		 * Marquee options definition
		 */
		[CCode(cname = "libvlc_video_marquee_option_t")]
		public enum MarqueeOption {
			[CCode(cname = "libvlc_marquee_Enable")]
			ENABLE,
			[CCode(cname = "libvlc_marquee_Text")]
			TEXT,
			[CCode(cname = "libvlc_marquee_Color")]
			COLOR,
			[CCode(cname = "libvlc_marquee_Opacity")]
			OPACITY,
			[CCode(cname = "libvlc_marquee_Position")]
			POSITION,
			[CCode(cname = "libvlc_marquee_Refresh")]
			REFRESH,
			[CCode(cname = "libvlc_marquee_Size")]
			SIZE,
			[CCode(cname = "libvlc_marquee_Timeout")]
			TIMEOUT,
			[CCode(cname = "libvlc_marquee_X")]
			X,
			[CCode(cname = "libvlc_marquee_Y")]
			Y
		}
		[CCode(cname = "libvlc_video_adjust_option_t")]
		public enum VideoAdjust {
			[CCode(cname = "libvlc_adjust_Enable")]
			ENABLE,
			[CCode(cname = "libvlc_adjust_Contrast")]
			CONTRAST,
			[CCode(cname = "libvlc_adjust_Brightness")]
			BRIGHTNESS,
			[CCode(cname = "libvlc_adjust_Hue")]
			HUE,
			[CCode(cname = "libvlc_adjust_Saturation")]
			SATURATION,
			[CCode(cname = "libvlc_adjust_Gamma")]
			GAMMA
		}
		/**
		 * The agl handler where the media player should render its video output.
		 */
		public uint32 agl {
			[CCode(cname = "libvlc_media_player_set_agl")]
			set;
			[CCode(cname = "libvlc_media_player_get_agl")]
			get;
		}
		/**
		 * The current video aspect ratio.
		 *
		 * The video aspect ratio or null if the default.
		 *
		 * Invalid aspect ratios are ignored.
		 */
		public string? aspect_ratio {
			[CCode(cname = "libvlc_video_get_aspect_ratio")]
			owned get;
			[CCode(cname = "libvlc_video_set_aspect_ratio")]
			set;
		}
		/**
		 * The current audio channel.
		 *
		 * @see AudioChannel
		 */
		public AudioChannel audio_channel {
			[CCode(cname = "libvlc_audio_get_channel")]
			get;
			[CCode(cname = "libvlc_audio_set_channel")]
			set;
		}
		/**
		 * The current audio delay in microseconds.
		 *
		 * The audio delay will be reset to zero each time the media changes.
		 */
		public int64 audio_delay {
			[CCode(cname = "libvlc_audio_get_delay")]
			get;
			[CCode(cname = "libvlc_audio_set_delay")]
			set;
		}
		/**
		 * The current audio track, or -1 if none.
		 */
		public int audio_track {
			[CCode(cname = "libvlc_audio_get_track")]
			get;
			[CCode(cname = "libvlc_audio_set_track")]
			set;
		}
		/**
		 * The number of available audio tracks, or -1 if unavailable.
		 */
		public int audio_track_count {
			[CCode(cname = "libvlc_audio_get_track_count")]
			get;
		}
		/**
		 * The description of available audio tracks.
		*/
		public track_description? audio_track_description {
			[CCode(cname = "libvlc_audio_get_track_description")]
			get;
		}
		/**
		 * Can this media player be paused?
		 */
		public bool can_pause {
			[CCode(cname = "libvlc_media_player_can_pause")]
			get;
		}
		/**
		 * The movie chapter (if applicable).
		 */
		public int chapter {
			[CCode(cname = "libvlc_media_player_set_chapter")]
			set;
			[CCode(cname = "libvlc_media_player_get_chapter")]
			get;
		}
		/**
		 * Get movie chapter count
		 */
		public int chapter_count {
			[CCode(cname = "libvlc_media_player_get_chapter_count")]
			get;
		}
		/**
		 * The current crop filter geometry.
		 */
		public string? crop_geometry {
			[CCode(cname = "libvlc_video_get_crop_geometry")]
			get;
			[CCode(cname = "libvlc_video_set_crop_geometry")]
			set;
		}
		/**
		 * Enable or disable deinterlace filter
		 */
		public string? deinterlace {
			[CCode(cname = "libvlc_video_set_deinterlace")]
			set;
		}
		/**
		 * The current audio device type.
		 *
		 * Device type describes something like character of output sound (i.e., stereo sound, 2.1, 5.1, etc.)
		 */
		public AudioDevice device_type {
			[CCode(cname = "libvlc_audio_output_get_device_type")]
			get;
			[CCode(cname = "libvlc_audio_output_set_device_type")]
			set;
		}
		/**
		 * The Event Manager from which the media player send event.
		 */
		public EventManager event_manager {
			[CCode(cname = "libvlc_media_player_event_manager")]
			get;
		}
		/**
		 * Movie fps rate
		 */
		public float fps {
			[CCode(cname = "libvlc_media_player_get_fps")]
			get;
		}
		/**
		 * Current fullscreen status.
		 *
		 * With most window managers, only a top-level windows can be in
		 * full-screen mode. Hence, this function will not operate properly if
		 * {@link xwindow} was used to embed the video in a non-top-level window.
		 * In that case, the embedding window must be reparented to the root window
		 * ''before'' fullscreen mode is enabled. You will want to reparent it back
		 * to its normal parent when disabling fullscreen.
		 */
		public bool fullscreen {
			[CCode(cname = "libvlc_set_fullscreen")]
			set;
			[CCode(cname = "libvlc_get_fullscreen")]
			get;
		}
		/**
		 * Current video height.
		 */
		[Deprecated(replacement = "get_size")]
		public int height {
			[CCode(cname = "libvlc_video_get_height")]
			get;
		}
		/**
		 * The Win32/Win64 API window handle (HWND) where the media player should
		 * render its video output.
		 *
		 * If LibVLC was built without Win32/Win64 API output support, then this
		 * has no effects.
		 */
		public void* hwnd {
			[CCode(cname = "libvlc_media_player_set_hwnd")]
			set;
			[CCode(cname = "libvlc_media_player_get_hwnd")]
			get;
		}
		public bool is_playing {
			[CCode(cname = "libvlc_media_player_is_playing")]
			get;
		}
		/**
		 * Is this media player seekable?
		 */
		public bool is_seekable {
			[CCode(cname = "libvlc_media_player_is_seekable")]
			get;
		}
		/**
		 * Enable or disable key press events handling, according to the LibVLC
		 * hotkeys configuration. By default and for historical reasons, keyboard
		 * events are handled by the LibVLC video widget.
		 *
		 * On X11, there can be only one subscriber for key press and mouse click
		 * events per window. If your application has subscribed to those events
		 * for the X window ID of the video widget, then LibVLC will not be able to
		 * handle key presses and mouse clicks in any case.
		 *
		 * This function is only implemented for X11 and Win32 at the moment.
		 */
		public bool key_input {
			[CCode(cname = "libvlc_video_set_key_input")]
			set;
		}
		/**
		 * The current movie length (in ms).
		 *
		 * @param p_mi the Media Player
		 * @return the movie length (in ms), or -1 if there is no media.
		 */
		public int64 length {
			[CCode(cname = "libvlc_media_player_get_length")]
			get;
		}
		/**
		 * The media that will be used by the media player.
		 */
		public Media<T>? media {
			[CCode(cname = "libvlc_media_player_set_media", simple_generics = true)]
			set;
			[CCode(cname = "libvlc_media_player_get_media", simple_generics = true)]
			get;
		}
		/**
		 * Enable or disable mouse click events handling. By default, those events
		 * are handled. This is needed for DVD menus to work, as well as a few
		 * video filters such as "puzzle".
		 *
		 * This function is only implemented for X11 and Win32 at the moment.
		 * @see key_input
		 */
		public bool mouse_input {
			[CCode(cname = "libvlc_video_set_mouse_input")]
			set;
		}
		/**
		 * Current mute status.
		 */
		public bool mute {
			[CCode(cname = "libvlc_audio_get_mute")]
			get;
			[CCode(cname = "libvlc_audio_set_mute")]
			set;
		}
		/**
		 * Pause or resume (no effect if there is no media)
		 *
		 * @param mp the Media Player
		 * @param do_pause play/resume if zero, pause if non-zero
		 */
		public bool paused {
			[CCode(cname = "libvlc_media_player_set_pause")]
			set;
		}
		/**
		 * The movie position.
		 */
		[CCode(cname = "libvlc_media_player_get_position")]
		public float position {
			[CCode(cname = "libvlc_media_player_get_position")]
			get;
			[CCode(cname = "libvlc_media_player_set_position")]
			set;
		}
		/**
		 * The requested movie play rate.
		 *
		 * Depending on the underlying media, the requested rate may be different
		 * from the real playback rate.
		 */
		public float rate {
			[CCode(cname = "libvlc_media_player_get_rate")]
			get;
			[CCode(cname = "libvlc_media_player_set_rate")]
			set;
		}
		/**
		 * The current video scaling factor.
		 *
		 * The currently configured zoom factor, or 0. if the video is set to fit
		 * to the output window/drawable automatically.
		 *
		 * That is the ratio of the number of pixels on screen to the number of
		 * pixels in the original decoded video in each dimension. Zero is a
		 * special value; it will adjust the video to the output window/drawable
		 * (in windowed mode) or the entire screen.
		 *
		 * Note that not all video outputs support scaling.
		 */
		public float scale {
			[CCode(cname = "libvlc_video_get_scale")]
			get;
			[CCode(cname = "libvlc_video_set_scale")]
			set;
		}
		/**
		 * Get current video subtitle.
		 *
		 * The video subtitle selected, or -1 if none
		 */
		public int spu {
			[CCode(cname = "libvlc_video_get_spu")]
			get;
		}
		/**
		 * The number of available video subtitles.
		 */
		public int spu_count {
			[CCode(cname = "libvlc_video_get_spu_count")]
			get;
			[CCode(cname = "libvlc_video_set_spu")]
			set;
		}
		/**
		 * The description of available video subtitles.
		 */
		public track_description? spu_description {
				[CCode(cname = "libvlc_video_get_spu_description")]
				owned get;
		}
		/**
		 * Current movie state
		 */
		public State state {
			[CCode(cname = "libvlc_media_player_get_state")]
			get;
		}
		/**
		 * The current teletext page.
		 */
		public bool teletext {
			[CCode(cname = "libvlc_video_get_teletext")]
			get;
			[CCode(cname = "libvlc_video_set_teletext")]
			set;
		}
		/**
		 * The current movie time (in ms).
		 */
		public int64 time {
			[CCode(cname = "libvlc_media_player_get_time")]
			get;
			[CCode(cname = "libvlc_media_player_set_time")]
			set;
		}
		/**
		 * The movie title
		 */
		public int title {
			[CCode(cname = "libvlc_media_player_set_title")]
			set;
			[CCode(cname = "libvlc_media_player_get_title")]
			get;
		}
		/**
		 * Get movie title count
		 * @return title number count, or -1
		 */
		public int title_count {
			[CCode(cname = "libvlc_media_player_get_title_count")]
			get;
		}
		/**
		 * The description of available titles.
		 */
		public track_description? title_description {
			[CCode(cname = "libvlc_video_get_title_description")]
			owned get;
		}
		/**
		 * The current video track or -1 if none.
		 */
		public int video_track {
			[CCode(cname = "libvlc_video_get_track")]
			get;
			[CCode(cname = "libvlc_video_set_track")]
			set;
		}
		/**
		 * The number of available video tracks.
		 */
		public int video_track_count {
			[CCode(cname = "libvlc_video_get_track_count")]
			get;
		}
		/**
		 * The description of available video tracks.
		 */
		public track_description? video_track_description {
				[CCode(cname = "libvlc_video_get_track_description")]
				get;
		}
		/**
		 * The current audio level
		 */
		public int volume {
			[CCode(cname = "libvlc_audio_set_volume")]
			set;
			[CCode(cname = "libvlc_audio_get_volume")]
			get;
		}
		/**
		 * How many video outputs does this media player have?
		 */
		public uint vout_count {
			[CCode(cname = "libvlc_media_player_has_vout")]
			get;
		}
		/**
		 * Current video width.
		 */
		[Deprecated(replacement = "get_size")]
		public int width {
			[CCode(cname = "libvlc_video_get_width")]
			get;
		}
		/**
		 * Is the player able to play
		 */
		public bool will_play {
			[CCode(cname = "libvlc_media_player_will_play")]
			get;
		}
		/**
		 * An X Window System drawable where the media player should render its
		 * video output. If LibVLC was built without X11 output support, then this
		 * has no effects.
		 *
		 * The specified identifier must correspond to an existing Input/Output class
		 * X11 window. Pixmaps are ''not'' supported. The caller shall ensure that
		 * the X11 server is the same as the one the VLC instance has been
		 * configured with.
		 */
		public X.Drawable xwindow {
			 [CCode(cname = "libvlc_media_player_set_xwindow")]
			 set;
			[CCode(cname = "libvlc_media_player_get_xwindow")]
			get;
		}
		[CCode(cname = "DisplayFunc", simple_generics = true)]
		public delegate void DisplayFunc<T,R>(T data, R picture);
		[CCode(cname = "LockFunc", simple_generics = true)]
		public delegate R LockFunc<T,R>(T data, [CCode(array_length = false)]out uint8[] plane);
		[CCode(cname = "UnlockFunc", simple_generics = true)]
		public delegate void UnlockFunc<T,R>(T data, R picture, [CCode(array_length = false)] ref uint8[] plane);
		/**
		 * Get float adjust option.
		 */
		[CCode(cname = "libvlc_video_get_adjust_float")]
		public float get_adjust_float(VideoAdjust option);
		/**
		 * Get integer adjust option.
		 */
		[CCode(cname = "libvlc_video_get_adjust_int")]
		public int get_adjust_int(VideoAdjust option);
		/**
		 * Get title chapter count
		 *
		 * @param title selected title
		 * @return number of chapters in title, or -1
		 */
		[CCode(cname = "libvlc_media_player_get_chapter_count_for_title")]
		public int get_chapter_count(int title);
		/**
		 * Get the description of available chapters for specific title.
		 *
		 * @param title selected title
		 * @return list containing description of available chapter for the title
		 */
		[CCode(cname = "libvlc_video_get_chapter_description")]
		public track_description? get_chapter_description(int title);
		/**
		 * Get the mouse pointer coordinates over a video. Coordinates are
		 * expressed in terms of the decoded video resolution, ''not'' in terms of
		 * pixels on the screen/viewport (to get the latter, you can query your
		 * windowing system directly).
		 *
		 * Either of the coordinates may be negative or larger than the
		 * corresponding dimension of the video, if the cursor is outside the
		 * rendering area.
		 *
		 * The coordinates may be out-of-date if the pointer is not located on the
		 * video rendering area. LibVLC does not track the pointer if it is outside
		 * of the video widget.
		 *
		 * LibVLC does not support multiple pointers (it does of course support
		 * multiple input devices sharing the same pointer) at the moment.
		 *
		 * @param num number of the video (starting from, and most commonly 0)
		 * @param px the abscissa
		 * @param py the ordinate
		 * @return 0 on success, -1 if the specified video does not exist
		 */
		[CCode(cname = "libvlc_video_get_cursor")]
		public bool get_cursor(uint num, out int px, out int py);
		/**
		 * Get integer logo option.
		 */
		[CCode(cname = "libvlc_video_get_logo_int")]
		public int get_logo_int(LogoOption option);
		/**
		 * Get an integer marquee option value
		 */
		[CCode(cname = "libvlc_video_get_marquee_int")]
		public int get_marquee_int(MarqueeOption option);
		/**
		 * Get a string marquee option value
		 */
		[CCode(cname = "libvlc_video_get_marquee_string")]
		public string get_marquee_string(MarqueeOption option);
		/**
		 * Get the pixel dimensions of a video.
		 *
		 * @param num number of the video (starting from, and most commonly 0)
		 * @param px the pixel width
		 * @param py the pixel height
		 * @return false on success, true if the specified video does not exist
		 */
		[CCode(cname = "libvlc_video_get_size")]
		public bool get_size(uint num, out uint px, out uint py);
		/**
		 * Set next chapter (if applicable)
		 */
		[CCode(cname = "libvlc_media_player_next_chapter")]
		public void next_chapter();
		/**
		 * Display the next frame (if supported)
		 */
		[CCode(cname = "libvlc_media_player_next_frame")]
		public void next_frame();
		/**
		 * Toggle pause (no effect if there is no media)
		 */
		[CCode(cname = "libvlc_media_player_pause")]
		public void pause();
		/**
		 * Play
		 * @return false if playback started (and was already started), or true on error.
		 */
		[CCode(cname = "libvlc_media_player_play")]
		public bool play();
		/**
		 * Set previous chapter (if applicable)
		 */
		[CCode(cname = "libvlc_media_player_previous_chapter")]
		public void previous_chapter();
		/**
		 * Retain a reference to a media player object.
		 */
		[CCode(cname = "libvlc_media_player_retain")]
		public void ref();
		/**
		 * Set adjust option as float. Options that take a different type value are
		 * ignored.
		 *
		 * @param option adust option to set
		 * @param value adjust option value
		 */
		[CCode(cname = "libvlc_video_set_adjust_float")]
		public void set_adjust_float(VideoAdjust option, float value);
		/**
		 * Set adjust option as integer. Options that take a different type value
		 * are ignored.
		 * Passing {@link VideoAdjust.ENABLE} as option value has the side effect
		 * of starting (arg !0) or stopping (arg 0) the adjust filter.
		 *
		 * @param option adust option to set
		 * @param value adjust option value
		 */
		[CCode(cname = "libvlc_video_set_adjust_int")]
		public void set_adjust_int(VideoAdjust option, int value);
		/**
		 * Set the audio output.
		 * Change will be applied after stop and play.
		 *
		 * @param name name of audio output,
		 * use name of {@link audio_output}
		 * @return false success, true on error
		 */
		[CCode(cname = "libvlc_audio_output_set")]
		public bool set_audio_output(string name);
		/**
		 * Set audio output device. Changes are only effective after stop and play.
		 *
		 * @param audio_output name of audio output, from {@link audio_output}
		 * @param device_id device
		 */
		[CCode(cname = "libvlc_audio_output_device_set")]
		public void set_audio_output_device(string audio_output, string device_id);
		/**
		 * Set callbacks and private data to render decoded video to a custom area
		 * in memory.
		 *
		 * Use {@link set_format} to configure the decoded format.
		 *
		 * Whenever a new video frame needs to be decoded, the lock callback is
		 * invoked. Depending on the video chroma, one or three pixel planes of
		 * adequate dimensions must be returned via the second parameter. Those
		 * planes must be aligned on 32-bytes boundaries.
		 *
		 * When the video frame is decoded, the unlock callback is invoked. The
		 * second parameter to the callback corresponds is the return value of the
		 * lock callbaclogk. The third parameter conveys the pixel planes for
		 * convenience.
		 *
		 * When the video frame needs to be shown, as determined by the media
		 * playback clock, the display callback is invoked. The second parameter
		 * also conveys the return value from the lock callback.
		 *
		 * @param lock_func callback to allocate video memory
		 * @param unlock_func callback to release video memory
		 * @param data private pointer for the three callbacks (as first parameter)
		 */
		[CCode(cname = "libvlc_video_set_callbacks", simple_generics = true)]
		public void set_callbacks<T,R>(LockFunc<T,R> lock_func, UnlockFunc<T,R> unlock_func, DisplayFunc<T,R> display_func, T data);
		/**
		 * Set decoded video chroma and dimensions.
		 *
		 * This only works in combination with {@link set_callbacks}.
		 *
		 * @param chroma a four-characters string identifying the chroma (e.g. "RV32" or "I420")
		 * @param width pixel width
		 * @param height pixel height
		 * @param pitch line pitch (in bytes)
		 */
		[CCode(cname = "libvlc_video_set_format")]
		public void set_format(string chroma, uint width, uint height, uint pitch);
		/**
		 * Set logo option as integer. Options that take a different type value
		 * are ignored.
		 * Passing libvlc_logo_enable as option value has the side effect of
		 * starting (arg !0) or stopping (arg 0) the logo filter.
		 *
		 * @param option logo option to set
		 * @param value logo option value
		 */
		[CCode(cname = "libvlc_video_set_logo_int")]
		public void set_logo_int(LogoOption option, int value);
		/**
		 * Set logo option as string. Options that take a different type value
		 * are ignored.
		 *
		 * @param option logo option to set
		 * @param value logo option value
		 */
		[CCode(cname = "libvlc_video_set_logo_string")]
		public void set_logo_string(LogoOption option, string value);
		/**
		 * Enable, disable or set an integer marquee option
		 *
		 * Setting {@link MarqueeOption.ENABLE} has the side effect of enabling (arg !0)
		 * or disabling (arg 0) the marq filter.
		 */
		[CCode(cname = "libvlc_video_set_marquee_int")]
		public void set_marquee_int(MarqueeOption option, int val);
		/**
		 * Set a marquee string option
		 */
		[CCode(cname = "libvlc_video_set_marquee_string")]
		public void set_marquee_string(MarqueeOption option, string text);
		/**
		 * Set new video subtitle file.
		 *
		 * @param subtitle new video subtitle file
		 * @return the success status (boolean)
		 */
		[CCode(cname = "libvlc_video_set_subtitle_file")]
		public bool set_subtitle_file(string subtitle);
		/**
		 * Stop (no effect if there is no media)
		 */
		[CCode(cname = "libvlc_media_player_stop")]
		public void stop();
		/**
		 * Take a snapshot of the current video window.
		 *
		 * If width AND height is 0, original size is used.
		 * If width XOR height is 0, original aspect-ratio is preserved.
		 *
		 * @param num number of video output (typically 0 for the first/only one)
		 * @param filepath the path where to save the screenshot to
		 * @param width the snapshot's width
		 * @param height the snapshot's height
		 * @return false on success, true if the video was not found
		 */
		[CCode(cname = "libvlc_video_take_snapshot")]
		public bool take_snapshot(uint num, string filepath, uint width, uint height);
		/**
		 * Toggle fullscreen status on non-embedded video outputs.
		 *
		 * The same limitations applies to this function
		 * as to {@link fullscreen}.
		 */
		[CCode(cname = "libvlc_toggle_fullscreen")]
		public void toggle_fullscreen();
		/**
		 * Toggle mute status.
		 */
		[CCode(cname = "libvlc_audio_toggle_mute")]
		public void toggle_mute();
		/**
		 * Toggle teletext transparent status on video output.
		 */
		[CCode(cname = "libvlc_toggle_teletext")]
		public void toggle_teletext();
		/**
		 * Release a media player after use
		 *
		 * Decrement the reference count of a media player object. If the reference
		 * count is 0, then the function will release the media player object. If
		 * the media player object has been released, then it should not be used
		 * again.
		 */
		[CCode(cname = "libvlc_media_player_release")]
		public void unref();
	}
	/**
	 * Description for audio output.
	 */
	[CCode(cname = "libvlc_audio_output_t", cheader_filename = "vlc/libvlc_media_player.h")]
	public struct audio_output {
		[CCode(cname = "description")]
		public string description;
		[CCode(cname = "name")]
		public string name;
		[CCode(cname = "p_next")]
		public audio_output? next;
	}
	/**
	 * A LibVLC event
	 */
	[CCode(cname = "libvlc_event_t", cheader_filename = "vlc/libvlc_events.h")]
	public struct event {
		public EventType type;
		/**
		 * Object emitting the event
		 */
		[CCode(cname = "p_obj")]
		void* emitter;
		[CCode(cname = "u.media_meta_changed.meta_type")]
		public Meta meta_changed;
		[CCode(cname = "u.media_subitem_added.new_child")]
		public Media media_subitem_added;
		[CCode(cname = "u.media_duration_changed.new_duration")]
		public int64 duration_changed;
		[CCode(cname = "u.media_parsed_changed.new_status")]
		public int new_status;
		[CCode(cname = "u.media_freed.md")]
		public Media freed_media;
		[CCode(cname = "u.media_state_changed.new_state")]
		public State new_state;
		[CCode(cname = "u.media_player_position_changed.new_position")]
		public float new_position;
		[CCode(cname = "u.media_player_time_changed.new_time")]
		public uint64 new_time;
		[CCode(cname = "u.media_player_title_changed.new_title")]
		public int new_title;
		[CCode(cname = "u.media_player_seekable_changed.new_seekable")]
		public int new_seekable;
		[CCode(cname = "u.media_player_pausable_changed.new_pausable")]
		public int new_pausable;
		[CCode(cname = "u.media_list_item_added.item")]
		public Media item;
		[CCode(cname = "u.media_list_item_added.index")]
		public int index;
		[CCode(cname = "u.media_player_snapshot_taken.filename")]
		public string snapshot_filename;
		[CCode(cname = "u.media_player_length_changed.new_length")]
		public uint64 new_length;
		[CCode(cname = "u.vlm_media_event.media_name")]
		string media_name;
		[CCode(cname = "u.vlm_media_event.instance_name")]
		string instance_name;
		[CCode(cname = "media_player_media_changed.new_media")]
		public Media new_media;
	}
	/**
	 * Media statistics
	 */
	[CCode(cname = "libvlc_media_stats_t", cheader_filename = "vlc/libvlc_media.h")]
	public struct media_stats {
		[CCode(cname = "i_decoded_audio")]
		int decoded_audio;
		[CCode(cname = "i_decoded_video")]
		int decoded_video;
		[CCode(cname = "f_demux_bitrate")]
		float demux_bitrate;
		[CCode(cname = "i_demux_corrupted")]
		int demux_corrupted;
		[CCode(cname = "i_demux_discontinuity")]
		int demux_discontinuity;
		[CCode(cname = "i_demux_read_bytes")]
		int demux_read_bytes;
		[CCode(cname = "i_displayed_pictures")]
		int displayed_pictures;
		[CCode(cname = "f_input_bitrate")]
		float input_bitrate;
		[CCode(cname = "i_lost_abuffers")]
		int lost_abuffers;
		[CCode(cname = "i_lost_pictures")]
		int lost_pictures;
		[CCode(cname = "i_played_abuffers")]
		int played_abuffers;
		[CCode(cname = "i_read_bytes")]
		int read_bytes;
		[CCode(cname = "f_send_bitrate")]
		float send_bitrate;
		[CCode(cname = "i_sent_bytes")]
		int sent_bytes;
		[CCode(cname = "i_sent_packets")]
		int sent_packets;
	}
	/**
	 * Rectangle type for video geometry
	 */
	[CCode(cname = "libvlc_rectangle_t", cheader_filename = "vlc/libvlc_media_player.h")]
	public struct rectangle {
		public int bottom;
		public int left;
		public int right;
		public int top;
	}
	/**
	 * Description for video, audio tracks and subtitles.
	 */
	[CCode(cname = "libvlc_track_description_t", destroy_function = "libvlc_track_description_release", cheader_filename = "vlc/libvlc_media_player.h")]
	public struct track_description {
		[CCode(cname = "i_id")]
		public int id;
		[CCode(cname = "name")]
		public string name;
		[CCode(cname = "p_next")]
		public track_description? next;
	}
	[CCode(cname = "libvlc_media_track_info_t", cheader_filename = "vlc/libvlc_media.h")]
	public struct track_info {
		[CCode(cname = "u.audio.i_channels")]
		uint audio_channels;
		[CCode(cname = "u.audio.i_rate")]
		uint audio_rate;
		[CCode(cname = "i_codec")]
		uint32 codec;
		[CCode(cname = "u.video.i_height")]
		uint height;
		[CCode(cname = "i_id")]
		int id;
		[CCode(cname = "i_level")]
		int level;
		[CCode(cname = "i_profile")]
		int profile;
		[CCode(cname = "i_type")]
		TrackType type;
		[CCode(cname = "u.video.i_width")]
		uint width;
	}
}
