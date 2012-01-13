/*
 * Homepage: http://www.khronos.org/registry/cl/sdk/
 * VAPI Homepage: https://github.com/apmasell/vapis/blob/master/opencl.vapi
 * VAPI Maintainer: Andre Masella <andre@masella.name>
 *
 * Copyright © 2007-2011 The Khronos Group Inc. Permission is hereby granted,
 * free of charge, to any person obtaining a copy of this software and/or
 * associated documentation files (the "Materials"), to deal in the Materials
 * without restriction, including without limitation the rights to use, copy,
 * modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Materials, and to permit persons to whom the Materials are furnished to do
 * so, subject to the condition that this copyright notice and permission
 * notice shall be included in all copies or substantial portions of the
 * Materials.
 */
#if APPLE
[CCode(cheader_filename = "OpenCL/cl.h")]
#else
[CCode(cheader_filename = "CL/cl.h")]
#endif
namespace OpenCL {
	[CCode(cname = "pfn_event_notify", always_declare = true, has_type_id = false)]
	public delegate void EventNotify(Event event, Event.State exec_status);
	[CCode(cname = "user_func", has_target = false, always_declare = true, has_type_id = false)]
	public delegate void NativeFunction([CCode(array_length = false)] uint8[] args);
	[CCode(cname = "pfn_notify", always_declare = true, has_type_id = false)]
	public delegate void Notify(string error, [CCode(array_length_type = "size_t")] uint8[] data);

	[CCode(cname = "struct _cl_command_queue", ref_function = "clRetainCommandQueue", unref_function = "clReleaseCommandQueue", ref_function_void = true, has_type_id = false)]
	public class CommandQueue {
		[CCode(cname = "cl_command_queue_info", cprefix = "CL_QUEUE_")]
		public enum Info {
			/**
			 * The context specified when the command-queue is created. ({@link Context})
			 */
			CONTEXT,
			/**
			 * The device specified when the command-queue is created. ({@link Device})
			 */
			DEVICE,
			/**
			 * The command-queue reference count.
			 *
			 * The reference count returned should be considered immediately stale.
			 * It is unsuitable for general use in applications. This feature is
			 * provided for identifying memory leaks.
			 */
			REFERENCE_COUNT,
			/**
			 * The currently specified properties for the command-queue. ({@link Properties})
			 */
			PROPERTIES
		}

		[CCode(cname = "cl_map_flags", cprefix = "CL_MAP_", has_type_id = false)]
		[Flags]
		public enum MapFlags {
			/**
			 * The region specified by (offset, cb) in the buffer object is being mapped for reading
			 */
			READ,
			/**
			 * The region specified by (offset, cb) in the buffer object is being mapped for writing
			 */
			WRITE
		}

		[CCode(cname = "cl_command_queue_properties", cprefix = "CL_QUEUE_", has_type_id = false)]
		[Flags]
		public enum Properties {
			/**
			 * Determines whether the commands queued in the command-queue are executed in-order or out-of-order.
			 *
			 * If set, the commands in the command-queue are executed out-of-order. Otherwise, commands are executed in-order.
			 */
			OUT_OF_ORDER_EXEC_MODE_ENABLE,
			/**
			 * Determines whether to profile commands in the command-queue.
			 *
			 * If set, the profiling of commands is enabled. Otherwise profiling of commands is disabled.
			 * @see Event.get_profiling_info
			 * @see Event.get_profiling_info_auto
			 */
			PROFILING_ENABLE
		}

		/**
		 * A synchronization point that enqueues a barrier operation.
		 *
		 * Add a synchronization point that ensures that all queued commands in the command queue have finished execution before the next batch of commands can begin execution.
		 */
		[CCode(cname = "clEnqueueBarrier")]
		public Error enqueue_barrier();

		/**
		 * Enqueues a command to copy a buffer object to an image object.
		 *
		 * The size in bytes of the region to be copied from source is computed as
		 * //width// * //height// * //depth// * //bytes/image// element if //dest//
		 * is a 3D image object and is computed as //width// * //height// *
		 * //bytes/image// element if it is a 2D image object.
		 *
		 * @param source A valid buffer object.
		 *
		 * @param dest A valid image object.
		 *
		 * @param source_offset The offset where to begin copying data from src_buffer.
		 *
		 * @param dest_origin The (x, y, z) offset in pixels where to begin copying
		 * data to dst_image. If //dest// is a 2D image object, the z value given
		 * by //dst_origin[2]// must be 0.
		 *
		 * @param region Defines the (width, height, depth) in pixels of the 2D or
		 * 3D rectangle to copy. If //dest// is a 2D image object, the depth value
		 * given by //region[2]// must be 1.
		 *
		 * @param event_wait_list Specify events that need to complete before this
		 * particular command can be executed. If null, then this particular
		 * command does not wait on any event to complete. The events specified in
		 * event_wait_list act as synchronization points. The context associated
		 * with events and command queue must be the same.
		 *
		 * @param event Returns an event object that identifies this particular
		 * copy command and can be used to query or queue a wait for this
		 * particular command to complete. If null, it will not be possible for the
		 * application to query the status of this command or queue a wait for this
		 * command to complete. {@link enqueue_barrier} can be used instead.
		 */
		[CCode(cname = "clEnqueueCopyBufferToImage")]
		public Error enqueue_copy_buffer_to_image(Memory source, Memory dest, size_t source_offset, [CCode(array_length = false)] size_t[] dest_origin, [CCode(array_length = false)] size_t region[], [CCode(array_length_pos = 5.1)] Event[]? event_wait_list, out Event event);

		/**
		 * Enqueues a command to copy a rectangular region from the buffer object to another buffer object.
		 *
		 * The command-queue in which the copy command will be queued. The OpenCL
		 * context associated with the command queue and both buffers must be the
		 * same.
		 *
		 * @param source_origin The (x, y, z) offset in the memory region
		 * associated with //source//. For a 2D rectangle region, the z value
		 * given by //source_origin[2]// should be 0. The offset in bytes is
		 * computed as //source_origin[2]// * //source_slice_pitch// +
		 * //source_origin[1]// * //source_row_pitch// + //source_origin[0]//.
		 *
		 * @param dest_origin The (x, y, z) offset in the memory region associated
		 * with //dest//. For a 2D rectangle region, the z value given by
		 * //dest_origin[2]// should be 0. The offset in bytes is computed as
		 * //dst_origin[2]// * //dst_slice_pitch// + //dst_origin[1]// *
		 * //dst_row_pitch// + //dst_origin[0]//.
		 *
		 * @param region The (width, height, depth) in bytes of the 2D or 3D
		 * rectangle being copied. For a 2D rectangle, the depth value given by
		 * //region[2]// should be 1.
		 *
		 * @param source_row_pitch The length of each row in bytes to be used for
		 * the memory region associated with //source//. If zero, it is computed
		 * as //region[0]//.
		 *
		 * @param source_slice_pitch The length of each 2D slice in bytes to be
		 * used for the memory region associated with //source//. If zero, it is
		 * computed as //region[1] * source_row_pitch//.
		 *
		 * @param dest_row_pitch The length of each row in bytes to be used for the
		 * memory region associated with //dest//. If zero, it is computed as
		 * //region[0]//.
		 *
		 * @param dest_slice_pitch The length of each 2D slice in bytes to be used
		 * for the memory region associated with //dest//. If zero, it is computed
		 * as //region[1] * dest_row_pitch//.
		 *
		 * @param event_wait_list Specify events that need to complete before this
		 * particular command can be executed. If null, then this particular
		 * command does not wait on any event to complete. The events specified in
		 * event_wait_list act as synchronization points. The context associated
		 * with the events and command queue must be the same.
		 *
		 * @param event Returns an event object that identifies this particular
		 * copy command and can be used to query or queue a wait for this
		 * particular command to complete. If null, it will not be possible for the
		 * application to query the status of this command or queue a wait for this
		 * command to complete. {@link enqueue_barrier} can be used instead.
		 */
		[CCode(cname = "clEnqueueCopyBufferRect")]
		public Error enqueue_copy_buffer_rect(Memory source, Memory dest, [CCode(array_length = false)] size_t[] source_origin, [CCode(array_length = false)] size_t[] dest_origin, size_t source_row_pitch, size_t source_slice_pitch, size_t dest_row_pitch, size_t dest_slice_pitch, [CCode(array_length_pos = 8.1)] Event[]? event_wait_list, out Event event);

		/**
		 * Enqueues a command to copy image objects.
		 *
		 * It is currently a requirement that the images memory objects must have
		 * the exact same image format (i.e., the {@link image_format} descriptor
		 * specified when the source and destination image are created must match).
		 *
		 * The source and destination images  can be 2D or 3D image objects
		 * allowing us to perform the following actions:<<BR>> Copy a 2D image
		 * object to a 2D image object.<<BR>> Copy a 2D image
		 * object to a 2D slice of a 3D image object.<<BR>> Copy a 2D slice of a 3D
		 * image object to a 2D image object.<<BR>> Copy a 3D image object to a 3D
		 * image object.
		 *
		 * @param source_origin Defines the starting (x, y, z) location in pixels
		 * in the source image from where to start the data copy. If the source
		 * image is a 2D image object, the z value given by //source_origin[2]//
		 * must be 0.
		 *
		 * @param dest_origin Defines the starting (x, y, z) location in pixels in
		 * the destination image from where to start the data copy. If destination
		 * image is a 2D image object, the z value given by //dest_origin[2]// must
		 * be 0.
		 *
		 * @param region Defines the (width, height, depth) in pixels of the 2D or
		 * 3D rectangle to copy. If either image is a 2D image object, the depth
		 * value given by //region[2]// must be 1.
		 *
		 * @param event_wait_list Specify events that need to complete before this
		 * particular command can be executed. If null, then this particular
		 * command does not wait on any event to complete. The events specified act
		 * as synchronization points. The context associated with the events and
		 * the command queue must be the same.
		 *
		 * @param event Returns an event object that identifies this particular
		 * copy command and can be used to query or queue a wait for this
		 * particular command to complete. If null, it will not be possible for the
		 * application to query the status of this command or queue a wait for this
		 * command to complete. {@link enqueue_barrier} can be used instead.
		 */
		[CCode(cname = "clEnqueueCopyImage")]
		public Error enqueue_copy_image(Memory source, Memory dest, [CCode(array_length = false)] size_t[] source_origin, [CCode(array_length = false)] size_t[] dest_origin, [CCode(array_length = false)] size_t[] region, [CCode(array_length_pos = 5.1)] Event[]? event_wait_list, out Event? event);

		/**
		 * Enqueues a command to copy an image object to a buffer object.
		 *
		 * @param origin Defines the (x, y, z) offset in pixels in the image from
		 * where to copy. If the image is a 2D image object, the z value given by
		 * //origin[2]// must be 0.
		 *
		 * @param region Defines the (width, height, depth) in pixels of the 2D or
		 * 3D rectangle to copy. If the image is a 2D image object, the depth value
		 * given by //region[2]// must be 1.
		 *
		 * @param offset The offset where to begin copying data into dst_buffer.
		 * The size in bytes of the region to be copied computed as //width// *
		 * //height// * //depth// * //bytes_per_image_element//, if the image is a
		 * 3D image object, and is computed as //width// * //height// *
		 * //bytes_per_image_element// if the image is a 2D image object.
		 *
		 * @param event_wait_list Specify events that need to complete before this
		 * particular command can be executed. If null then this particular command
		 * does not wait on any event to complete. The events specified act as
		 * synchronization points. The context associated with events and the
		 * command queue must be the same.
		 *
		 * @param event Returns an event object that identifies this particular
		 * copy command and can be used to query or queue a wait for this
		 * particular command to complete. If null, it will not be possible for the
		 * application to query the status of this command or queue a wait for this
		 * command to complete. {@link enqueue_barrier} can be used instead.
		 */
		[CCode(cname = "clEnqueueCopyImageToBuffer")]
		public Error enqueue_copy_image_to_buffer(Memory image, Memory buffer, [CCode(array_length = false)] size_t[] origin[3], [CCode(array_length = false)] size_t[] region, size_t offset, [CCode(array_length_pos = 5.1)] Event[]? event_wait_list, out Event? event);

		/**
		 * Enqueues a command to map a region of the buffer object given by buffer into the host address space and returns a pointer to this mapped region.
		 *
		 * @param blocking Indicates if the map operation is blocking or
		 * non-blocking. If true, this method does not return until the specified
		 * region in buffer can be mapped.  Otherwise, the pointer to the mapped
		 * region returned by this method cannot be used until the map command has
		 * completed. The event argument returns an event object which can be used
		 * to query the execution status of the map command. When the map command
		 * is completed, the application can access the contents of the mapped
		 * region using the pointer returned.
		 *
		 * @param buffer A valid buffer object. The OpenCL context associated with
		 * the command queue and the buffer must be the same.
		 *
		 * @param offset The offset in bytes in the buffer object that is being mapped.
		 *
		 * @param cb The size of the region in the buffer object that is being mapped.
		 *
		 * @param event_wait_list Specify events that need to complete before this
		 * particular command can be executed. If null, then this particular
		 * command does not wait on any event to complete. The events specified act
		 * as synchronization points. The context associated with events and the
		 * command queue must be the same.
		 *
		 * @param event Returns an event object that identifies this particular
		 * copy command and can be used to query or queue a wait for this
		 * particular command to complete. If null, it will not be possible for the
		 * application to query the status of this command or queue a wait for this
		 * command to complete.
		 *
		 * @param errcode Returns an appropriate error code. If null, no error code
		 * is returned.
		 */
		[CCode(cname = "clEnqueueMapBuffer")]
		public void* enqueue_map(Memory buffer, bool blocking, MapFlags flags, size_t offset, size_t cb, [CCode(array_length_pos = 5.1)] Event[]?  event_wait_list, out Event? event, out Error errcode);

		/**
		 * Enqueues a command to map a region of an image object into the host address space and returns a pointer to this mapped region.
		 *
		 * If the image object is created with {@link Memory.Flags.USE_HOST_PTR}
		 * set, the following will be true:<<BR>> The //host_ptr// specified in
		 * {@link Context.create_image_2d} or {@link Context.create_image_3d} is
		 * guaranteed to contain the latest bits in the region being mapped when
		 * the method has completed.<<BR>> The pointer value returned will be
		 * derived from the //host_ptr// specified when the image object is
		 * creat.<<BR>> Mapped image objects are unmapped using
		 * {@link enqueue_unmap}.
		 *
		 * The contents of the regions of a memory object mapped for writing (i.e.,
		 * {@link MapFlags.WRITE} is set) are considered to be undefined until this
		 * region is unmapped. Reads and writes by a kernel executing on a device
		 * to a memory region(s) mapped for writing are undefined.
		 *
		 * Multiple command-queues can map a region or overlapping regions of a
		 * memory object for reading (i.e., {@link MapFlags.READ}). The contents of
		 * the regions of a memory object mapped for reading can also be read by
		 * kernels executing on a device(s). The behavior of writes by a kernel
		 * executing on a device to a mapped region of a memory object is
		 * undefined. Mapping (and unmapping) overlapped regions of a memory object
		 * for writing is undefined.
		 *
		 * The behavior of OpenCL function calls that enqueue commands that write
		 * or copy to regions of a memory object that are mapped is undefined.
		 *
		 * The pointer returned maps a 2D or 3D region starting at origin and is at
		 * least (//image_row_pitch// * //region[1]//) pixels in size for a 2D
		 * image, and is at least (//image_slice_pitch// * //region[2]//) pixels in
		 * size for a 3D image. The result of a memory access outside this region
		 * is undefined.
		 *
		 * @param image A valid image object. The OpenCL context associated with
		 * the command queue and the image must be the same.
		 *
		 * @param blocking Indicates if the map operation is blocking or
		 * non-blocking. If true, this method does not return until the specified
		 * region in image can be mapped.  Otherwise the pointer to the mapped
		 * region returned cannot be used until the map command has completed. The
		 * event argument returns an event object which can be used to query the
		 * execution status of the map command. When the map command is completed,
		 * the application can access the contents of the mapped region using the
		 * pointer returned.
		 *
		 * @param origin Define the (x, y, z) offset in pixels of the 2D or 3D
		 * rectangle region that is to be mapped. If image is a 2D image object,
		 * the z value given by //origin[2]// must be 0.
		 *
		 * @param region Define the (width, height, depth) in pixels of the 2D or
		 * 3D rectangle region that is to be mapped. If image is a 2D image object,
		 * the z value given by //region[2]// must be 1.
		 *
		 * @param image_row_pitch Returns the scan-line pitch in bytes for the
		 * mapped region.
		 *
		 * @param image_slice_pitch Returns the size in bytes of each 2D slice for
		 * the mapped region. For a 2D image, zero is returned.
		 *
		 * @param event_wait_list Specify events that need to complete before this
		 * method can be executed. If null, then the method does not wait on any
		 * event to complete. The events specified act as synchronization points.
		 * The context associated with the events and the command queue must be the
		 * same.
		 *
		 * @param event Returns an event object that identifies this particular
		 * copy command and can be used to query or queue a wait for this
		 * particular command to complete. If null, it will not be possible for the
		 * application to query the status of this command or queue a wait for this
		 * command to complete.
		 *
		 * @param errcode Returns an appropriate error code. If null, no error code
		 * is returned.
		 */
		[CCode(cname = "clEnqueueMapImage")]
		public void* enqueue_map_image (Memory image, bool blocking, MapFlags flags, [CCode(array_length = false)] size_t[] origin, [CCode(array_length = false)] size_t[] region, out	size_t image_row_pitch, out	size_t image_slice_pitch, [CCode(array_length_pos = 7.1)] Event[]? event_wait_list, out Event event, out Error errcode);

		/**
		 * Enqueues a marker command.
		 *
		 * The marker command is not completed until all commands enqueued before
		 * it have completed. The marker command returns an event which can be
		 * waited on, i.e., this event can be waited on to ensure that all commands
		 * which have been queued before the market command have been completed.
		 */
		[CCode(cname = "clEnqueueMarker")]
		public Error enqueue_marker(Event event);

		/**
		 * Enqueues a command to execute a native C/C++ function not compiled using
		 * the OpenCL compiler.
		 *
		 * A native user function can only be executed on a command-queue created
		 * on a device that has {@link ExecutionCapabilities.NATIVE_KERNEL}
		 * capability set in {@link DeviceInfo.EXECUTION_CAPABILITIES}.
		 *
		 * The data pointed to by args will be copied and a pointer to this copied
		 * region will be passed to func. The copy needs to be done because the
		 * memory objects that args may contain need to be modified and replaced by
		 * appropriate pointers to global memory. When this method returns, the
		 * memory region pointed to by args can be reused by the application.
		 *
		 * @param func the native function to be called.
		 *
		 * @param args the data that will be passed to the native function.
		 *
		 * @param mem_list A list of valid buffer objects. The buffer object values
		 * specified are memory object handles returned by {@link Context.create_buffer}
		 * or null.
		 *
		 * @param args_mem_loc A pointer to appropriate locations that args points
		 * to where memory object handles are stored. Before the user function is
		 * executed, the memory object handles are replaced by pointers to global
		 * memory.
		 *
		 * @param event_wait_list Specify events that need to complete before this
		 * particular command can be executed. If the list is null, then this
		 * particular command does not wait on any event to complete. Otherwise,
		 * the events specified act as synchronization points. The context
		 * associated with events in the list and this command queue must be the
		 * same.
		 *
		 * @param event Returns an event object that identifies this particular
		 * kernel execution instance. Event objects are unique and can be used to
		 * identify a particular kernel execution instance later on. If event is
		 * null, no event will be created for this kernel execution instance and
		 * therefore it will not be possible for the application to query or queue
		 * a wait for this particular kernel execution instance.
		 */
		[CCode(cname = "clEnqueueNativeKernel")]
		public Error enqueue_native(NativeFunction func, uint8[]? args, [CCode(array_length_pos = 2.1)] Memory[]? mem_list, void** args_mem_loc, [CCode(array_length_pos = 2.1)] Event[]? event_wait_list, out Event? result);

		/**
		 * Enqueue commands to read from a buffer object to host memory.
		 *
		 * Calling this method to read a region of the buffer object with the
		 * //ptr// argument value set to //host_ptr// + //offset//, where host_ptr
		 * is a pointer to the memory region specified when the buffer object being
		 * read is created with {@link Memory.Flags.USE_HOST_PTR}, must meet the following
		 * requirements in order to avoid undefined behavior:<<BR>> All commands
		 * that use this buffer object or a memory object (buffer or image) created
		 * from this buffer object have finished execution before the read command
		 * begins execution.<<BR>> The buffer object or memory objects created from
		 * this buffer object are not mapped.<<BR>> The buffer object or memory
		 * objects created from this buffer object are not used by any
		 * command-queue until the read command has finished execution.<<BR>>
		 *
		 * @param buffer Refers to a valid buffer object.
		 *
		 * @param blocking_read Indicates if the read operations are blocking or
		 * non-blocking. If true, this method does not return until the buffer data
		 * has been read and copied into memory pointed to by //ptr//. Otherwise,
		 * this method queues a non-blocking read command and returns. The contents
		 * of the buffer that //ptr// points to cannot be used until the read
		 * command has completed. The event argument returns an event object which
		 * can be used to query the execution status of the read command. When the
		 * read command has completed, the contents of the buffer that //ptr//
		 * points to can be used by the application.
		 *
		 * @param offset The offset in bytes in the buffer object to read from.
		 *
		 * @param cb The size in bytes of data being read.
		 *
		 * @param ptr The pointer to buffer in host memory where data is to be read into.
		 *
		 * @param event_wait_list Events that need to complete before this
		 * particular command can be executed. If null, then this particular
		 * command does not wait on any event to complete. The events specified act
		 * as synchronization points. The context associated with events and
		 * command queue must be the same.
		 *
		 * @param event Returns an event object that identifies this particular
		 * read command and can be used to query or queue a wait for this
		 * particular command to complete. This can be null in which case it will
		 * not be possible for the application to query the status of this command
		 * or queue a wait for this command to complete.
		 */
		[CCode(cname = "clEnqueueReadBuffer")]
		public Error enqueue_read_buffer(Memory buffer, bool blocking_read, size_t offset, size_t cb, void *ptr, [CCode(array_length_pos = 5.1)] Event[]? event_wait_list, out Event? event);

		/**
		 * Enqueue commands to read from a rectangular region from a buffer object
		 * to host memory.
		 *
		 * Calling this method to read a region of the buffer object with the
		 * //ptr// argument value set to //host_ptr// and //host_origin//,
		 * //buffer_origin// values are the same, where //host_ptr// is a pointer
		 * to the memory region specified when the buffer object being read is
		 * created with {@link Memory.Flags.USE_HOST_PTR}, must meet the same
		 * requirements given for {@link enqueue_read_buffer}.

		 * @param buffer Refers to a valid buffer object.
		 *
		 * @param blocking_read Indicates if the read operations are blocking or
		 * non-blocking. If true, the method does not return until the buffer data
		 * has been read and copied into memory pointed to by //ptr//.  Otherwise,
		 * this method queues a non-blocking read command and returns. The contents
		 * of the buffer that //ptr// points to cannot be used until the read
		 * command has completed. The event argument argument returns an event
		 * object which can be used to query the execution status of the read
		 * command. When the read command has completed, the contents of the buffer
		 * that //ptr// points to can be used by the application.
		 *
		 * @param buffer_origin The (x, y, z) offset in the memory region
		 * associated with buffer. For a 2D rectangle region, the z value given by
		 * //buffer_origin[2]// should be 0. The offset in bytes is computed as
		 * //buffer_origin[2]// * //buffer_slice_pitch// + //buffer_origin[1]// *
		 * //buffer_row_pitch// + //buffer_origin[0]//.
		 *
		 * @param host_origin The (x, y, z) offset in the memory region pointed to
		 * by ptr. For a 2D rectangle region, the z value given by
		 * //host_origin[2]// should be 0. The offset in bytes is computed as
		 * //host_origin[2]// * //host_slice_pitch// + //host_origin[1]// *
		 * //host_row_pitch// + //host_origin[0]//.
		 *
		 * @param region The (width, height, depth) in bytes of the 2D or 3D
		 * rectangle being read or written. For a 2D rectangle copy, the depth
		 * value given by //region[2]// should be 1.
		 *
		 * @param buffer_row_pitch The length of each row in bytes to be used for
		 * the memory region associated with buffer. If zero, its is computed as
		 * //region[0]//.
		 *
		 * @param buffer_slice_pitch The length of each 2D slice in bytes to be
		 * used for the memory region associated with buffer. If zero, it is
		 * computed as //region[1]// * //buffer_row_pitch//.
		 *
		 * @param host_row_pitch The length of each row in bytes to be used for the
		 * memory region pointed to by //ptr//. If zero, it is computed as
		 * //region[0]//.
		 *
		 * @param host_slice_pitch The length of each 2D slice in bytes to be used
		 * for the memory region pointed to by //ptr//. If zero, it is computed as
		 * //region[1]// * //host_row_pitch//.
		 *
		 * @param ptr The pointer to buffer in host memory where data is to be read
		 * into.
		 *
		 * @param event_wait_list The events that need to complete before this
		 * particular command can be executed. If null, then this particular
		 * command does not wait on any event to complete. The events specified act
		 * as synchronization points. The context associated with events and
		 * command queue must be the same.
		 *
		 * @param event Returns an event object that identifies this particular
		 * read command and can be used to query or queue a wait for this
		 * particular command to complete. If null, it will not be possible for the
		 * application to query the status of this command or queue a wait for this
		 * command to complete.
		 */
		[CCode(cname = "clEnqueueReadBufferRect")]
		public Error enqueue_read_buffer_rect(Memory buffer, bool blocking_read, [CCode(array_length = false)] size_t[] buffer_origin, [CCode(array_length = false)] size_t[] host_origin, [CCode(array_length = false)] size_t[] region, size_t buffer_row_pitch, size_t buffer_slice_pitch, size_t host_row_pitch, size_t host_slice_pitch, void *ptr, [CCode(array_length_pos = 10.1)] Event[]? event_wait_list, out Event? event);

		/**
		 * Enqueues a command to read from a 2D or 3D image object to host memory.
		 *
		 * Calling this method to read a region of the image with the //ptr//
		 * argument value set to //host_ptr// + (//origin//[2] *
		 * //image_slice_pitch// + //origin//[1] * //image_row_pitch// +
		 * //origin//[0] * //bytes_per_pixel//), where host_ptr is a pointer to the
		 * memory region specified when the image being read is created with
		 * {@link Memory.Flags.USE_HOST_PTR}, must meet the following requirements
		 * in order to avoid undefined behavior:<<BR> All commands that use this
		 * image object have finished execution before the read command begins
		 * execution.<<BR> The //row_pitch// and //slice_pitch// argument values
		 * must be set to the image row pitch and slice pitch.<<BR> The image
		 * object is not mapped.<<BR> The image object is not used by any
		 * command-queue until the read command has finished execution.
		 *
		 * @param image Refers to a valid 2D or 3D image object.
		 *
		 * @param blocking_read Indicates if the read operations are blocking or
		 * non-blocking. If true, this method does not return until the buffer data
		 * has been read and copied into memory pointed to by //ptr//. Otherwise,
		 * this method queues a non-blocking read command and returns. The contents
		 * of the buffer that //ptr// points to cannot be used until the read
		 * command has completed. The event argument returns an event object which
		 * can be used to query the execution status of the read command. When the
		 * read command has completed, the contents of the buffer that //ptr// points
		 * to can be used by the application.
		 *
		 * @param origin Defines the (x, y, z) offset in pixels in the image from where to read. If image is a 2D image object, the z value given by //origin[2]// must be 0.
		 *
		 * @param region Defines the (width, height, depth) in pixels of the 2D or
		 * 3D rectangle being read. If image is a 2D image object, the depth value
		 * given by //region[2]// must be 1.
		 *
		 * @param row_pitch The length of each row in bytes. This value must be
		 * greater than or equal to the element size in bytes multiplied by width.
		 * If //row_pitch// is set to 0, the appropriate row pitch is calculated
		 * based on the size of each element in bytes multiplied by width.
		 *
		 * @param slice_pitch Size in bytes of the 2D slice of the 3D region of a
		 * 3D image being read. This must be 0 if image is a 2D image. This value
		 * must be greater than or equal to //row_pitch// * //height//. If
		 * //slice_pitch// is set to 0, the appropriate slice pitch is calculated
		 * based on the //row_pitch// * //height//.
		 *
		 * @param ptr The pointer to a buffer in host memory where image data is to
		 * be read from.
		 *
		 * @param event_wait_list Specify events that need to complete before this
		 * particular command can be executed. If null, then this particular
		 * command does not wait on any event to complete. The events specified act
		 * as synchronization points. The context associated with the events and
		 * the command queue must be the same.
		 *
		 * @param event Returns an event object that identifies this particular
		 * read command and can be used to query or queue a wait for this
		 * particular command to complete. If null, it will not be possible for the
		 * application to query the status of this command or queue a wait for this
		 * command to complete.
		 */
		[CCode(cname = "clEnqueueReadImage")]
		public Error enqueue_read_image(Memory image, bool blocking_read, [CCode(array_length = false)] size_t[] origin, [CCode(array_length = false)] size_t[] region, size_t row_pitch, size_t slice_pitch, void* ptr, [CCode(array_length_pos = 8.1)] Event[]? event_wait_list, out Event? event);

		/**
		 * Enqueues a command to execute a kernel on a device.
		 *
		 * The values specified in global_work_size + corresponding values
		 * specified in global_work_offset cannot exceed the range given by the
		 * sizeof(size_t) for the device on which the kernel execution will be
		 * enqueued. The sizeof(size_t) for a device can be determined using
		 * {@link DeviceInfo.ADDRESS_BITS}. If, for example, {@link DeviceInfo.ADDRESS_BITS}
		 * = 32, i.e. the device uses a 32-bit address space, size_t is a 32-bit
		 * unsigned integer and global_work_size values must be in the range 1 ..
		 * 2^32 - 1. Values outside this range return a {@link Error.OUT_OF_RESOURCES} error.
		 *
		 * These work-group instances are executed in parallel across multiple
		 * compute units or concurrently on the same compute unit.
		 *
		 * Each work-item is uniquely identified by a global identifier. The global
		 * ID, which can be read inside the kernel, is computed using the value
		 * given by global_work_size and global_work_offset. In addition, a
		 * work-item is also identified within a work-group by a unique local ID.
		 * The local ID, which can also be read by the kernel, is computed using
		 * the value given by local_work_size. The starting local ID is always (0,
		 * 0, ... 0).
		 *
		 * @param kernel A valid kernel object. The OpenCL context associated with
		 * kernel and command queue must be the same.
		 *
		 * @param work_dim The number of dimensions used to specify the global
		 * work-items and work-items in the work-group. This must be greater than
		 * zero and less than or equal to {@link DeviceInfo.MAX_WORK_ITEM_DIMENSIONS}.
		 *
		 * @param global_work_offset An array of //work_dim// unsigned values that
		 * describe the offset used to calculate the global ID of a work-item. If
		 * null, the global IDs start at offset (0, 0, ... 0).
		 *
		 * @param global_work_size An array of //work_dim// unsigned values that
		 * describe the number of global work-items in work_dim dimensions that
		 * will execute the kernel function. The total number of global work-items
		 * is computed as global_work_size[0] ... global_work_size[work_dim - 1].
		 *
		 * @param local_work_size An array of //work_dim// unsigned values that
		 * describe the number of work-items that make up a work-group (also
		 * referred to as the size of the work-group) that will execute the kernel
		 * specified by kernel. The total number of work-items in a work-group is
		 * computed as local_work_size[0] ...  local_work_size[work_dim - 1]. The
		 * total number of work-items in the work-group must be less than or equal
		 * to the {@link DeviceInfo.MAX_WORK_GROUP_SIZE} value specified in table of OpenCL
		 * Device Queries for {@link Device.get_info} and the number of work-items
		 * specified in local_work_size[0],... local_work_size[work_dim - 1] must
		 * be less than or equal to the corresponding values specified by
		 * {@link DeviceInfo.MAX_WORK_GROUP_SIZE}[0],....
		 * {@link DeviceInfo.MAX_WORK_GROUP_SIZE}[work_dim - 1]. The explicitly
		 * specified local_work_size will be used to determine how to break the
		 * global work-items specified by global_work_size into appropriate
		 * work-group instances. If local_work_size is specified, the values
		 * specified in global_work_size[0],... global_work_size[work_dim - 1] must
		 * be evenly divisible by the corresponding values specified in
		 * local_work_size[0],... local_work_size[work_dim - 1].<<BR>>
		 * The work-group size to be used for kernel can also be specified in the
		 * program source using the _\_attribute_\_((reqd_work_group_size(X, Y,
		 * Z))) qualifier. In this case the size of work group specified by
		 * local_work_size must match the value specified by the
		 * reqd_work_group_size _\_attribute_\_ qualifier.<<BR>>
		 * If null, the OpenCL implementation will determine how to be break the
		 * global work-items into appropriate work-group instances.
		 *
		 * @param event_wait_list Specify events that need to complete before this
		 * particular command can be executed. If list is null, then this
		 * particular command does not wait on any event to complete. The events
		 * specified act as synchronization points. The context associated with
		 * events in this_list and command queue must be the same.
		 *
		 * @param event Returns an event object that identifies this particular
		 * kernel execution instance. Event objects are unique and can be used to
		 * identify a particular kernel execution instance later on. If event is
		 * null, no event will be created for this kernel execution instance and
		 * therefore it will not be possible for the application to query or queue
		 * a wait for this particular kernel execution instance.
		 */
		[CCode(cname = "clEnqueueNDRangeKernel")]
		public Error enqueue_range(Kernel kernel, uint work_dim,[CCode(array_length = false)]  size_t[]? global_work_offset, [CCode(array_length = false)]  size_t[]? global_work_size, [CCode(array_length = false)]  size_t[]? local_work_size, [CCode(array_length_pos = 1.1)] Event[]? event_wait_list, out Event? event);

		/**
		 * Enqueues a command to execute a kernel on a device.
		 *
		 *
		 * The kernel is executed using a single work-item.
		 *
		 * This method is equivalent to calling {@link enqueue_range}(kernel, 1,
		 * null, size_t[] {1}, size_t[] {1}, event_wait_list, out event).
		 *
		 * @param kernel A valid kernel object. The OpenCL context associated with
		 * kernel and command queue must be the same.
		 *
		 * @param event_wait_list Specify events that need to complete before this
		 * particular command can be executed. If list is null, then this
		 * particular command does not wait on any event to complete. The events
		 * specified act as synchronization points. The context associated with
		 * events in this_list and command queue must be the same.
		 *
		 * @param event Returns an event object that identifies this particular
		 * kernel execution instance. Event objects are unique and can be used to
		 * identify a particular kernel execution instance later on. If event is
		 * null, no event will be created for this kernel execution instance and
		 * therefore it will not be possible for the application to query or queue
		 * a wait for this particular kernel execution instance.
		 */
		[CCode(cname = "clEnqueueTask")]
		public Error enqueue_task(Kernel kernel, [CCode(array_length_pos = 1.1)] Event[]? event_wait_list, out Event? event);

		/**
		 * Enqueues a command to unmap a previously mapped region of a memory object.
		 *
		 * Reads or writes from the host using the pointer returned by {@link enqueue_map}
		 * or {@link enqueue_map_image} considered to be complete.
		 *
		 * {@link enqueue_map} and {@link enqueue_map_image} increment the mapped
		 * count of the memory object. The initial mapped count value of a memory
		 * object is zero. Multiple calls to {@link enqueue_map} or {@link enqueue_map_image}
		 * on the same memory object will increment this mapped count by
		 * appropriate number of calls. This method decrements the mapped
		 * count of the memory object.
		 *
		 * {@link enqueue_map} and {@link enqueue_map_image} act as synchronization
		 * points for a region of the buffer object being mapped.
		 *
		 * @param memobj A valid memory object. The OpenCL context associated with
		 * the command queue and memobj must be the same.
		 *
		 * @param mapped_ptr The host address returned by a previous call to
		 * {@link enqueue_map} or {@link enqueue_map_image} for memobj.
		 *
		 * @param event_wait_list Specify events that need to complete before this
		 * call can be executed. If null, then this method does not wait on any
		 * event to complete. The events specified act as synchronization points.
		 * The context associated with the events and the command queue must be the
		 * same.
		 *
		 * @param event Returns an event object that identifies this particular
		 * copy command and can be used to query or queue a wait for this
		 * particular command to complete. If null, it will not be possible for the
		 * application to query the status of this command or queue a wait for this
		 * command to complete. {@link enqueue_barrier} can be used instead.
		 */
		[CCode(cname = "clEnqueueUnmapMemObject")]
		public Error enqueue_unmap(Memory memobj, void* mapped_ptr, [CCode(array_length_pos = 2.1)] Event[]?  event_wait_list, out Event? event);

		/**
		 * Enqueue commands to write to a buffer object from host memory.
		 *
		 * Calling this method to update the latest bits in a region of the buffer
		 * object with the //ptr// argument value set to //host_ptr// + //offset//,
		 * where host_ptr is a pointer to the memory region specified when the
		 * buffer object being written is created with {@link Memory.Flags.USE_HOST_PTR},
		 * must meet the following requirements in order to avoid undefined
		 * behavior:<<BR>>
		 * All commands that use this buffer object or a memory object (buffer or
		 * image) created from this buffer object have finished execution before
		 * the read command begins execution.<<BR>> The buffer object or memory
		 * objects created from this buffer object are not mapped.<<BR>> The buffer
		 * object or memory objects created from this buffer object are not used by
		 * any command-queue until the read command has finished execution.<<BR>>
		 *
		 * @param buffer Refers to a valid buffer object.
		 *
		 * @param blocking_write Indicates if the write operations are blocking or
		 * nonblocking.  If true, the OpenCL implementation copies the data
		 * referred to by ptr and enqueues the write operation in the
		 * command-queue. The memory pointed to by //ptr// can be reused by the
		 * application after the method returns.  Otherwise the OpenCL
		 * implementation will use //ptr// to perform a non-blocking write. As the
		 * write is non-blocking the implementation can return immediately. The
		 * memory pointed to by ptr cannot be reused by the application after the
		 * call returns. The event argument returns an event object which can be
		 * used to query the execution status of the write command. When the write
		 * command has completed, the memory pointed to by //ptr// can then be
		 * reused by the application.
		 *
		 * @param offset The offset in bytes in the buffer object to write to.
		 *
		 * @param cb The size in bytes of daa being written.
		 *
		 * @param ptr The pointer to buffer in host memory where data is to be written from.
		 *
		 * @param event_wait_list The events that need to complete before this
		 * particular command can be executed. If null, then this particular
		 * command does not wait on any event to complete. The events specified in
		 * event_wait_list act as synchronization points. The context associated
		 * with events and command queue must be the same.
		 *
		 * @param event Returns an event object that identifies this particular
		 * write command and can be used to query or queue a wait for this
		 * particular command to complete. If null, it will not be possible for the
		 * application to query the status of this command or queue a wait for this
		 * command to complete.
		 */
		[CCode(cname = "clEnqueueWriteBuffer")]
		public Error enqueue_write_buffer(Memory buffer, bool blocking_write, size_t offset, size_t cb, void *ptr, [CCode(array_length_pos = 5.1)] Event[]? event_wait_list, out Event event);

		/**
		 * Enqueue commands to write a rectangular region to a buffer object from
		 * host memory.
		 *
		 * Calling this method to update the latest bits in a region of the buffer
		 * object with the //ptr// argument value set to //host_ptr// and
		 * //host_origin//, //buffer_origin// values are the same, where
		 * //host_ptr// is a pointer to the memory region specified when the buffer
		 * object being written is created with {@link Memory.Flags.USE_HOST_PTR},
		 * must meet the following requirements in order to avoid undefined
		 * behavior:<<BR>> The host memory region given by (//buffer_origin//
		 * region) contains the latest bits when the enqueued write command begins
		 * execution.<<BR>> The buffer object or memory objects created from this
		 * buffer object are not mapped.<<BR>> The buffer object or memory objects
		 * created from this buffer object are not used by any command-queue until
		 * the write command has finished execution.
		 *
		 * @param buffer Refers to a valid buffer object.
		 *
		 * @param blocking_write Indicates if the write operations are blocking or
		 * nonblocking.  If true, the OpenCL implementation copies the data
		 * referred to by ptr and enqueues the write operation in the
		 * command-queue. The memory pointed to by //ptr// can be reused by the
		 * application after the method returns.  Otherwise the OpenCL
		 * implementation will use //ptr// to perform a non-blocking write. As the
		 * write is non-blocking the implementation can return immediately. The
		 * memory pointed to by ptr cannot be reused by the application after the
		 * call returns. The event argument returns an event object which can be
		 * used to query the execution status of the write command. When the write
		 * command has completed, the memory pointed to by //ptr// can then be
		 * reused by the application.
		 *
		 * @param buffer_origin The (x, y, z) offset in the memory region
		 * associated with buffer. For a 2D rectangle region, the z value given by
		 * //buffer_origin[2]// should be 0. The offset in bytes is computed as
		 * //buffer_origin[2]// * //buffer_slice_pitch// + //buffer_origin[1]// *
		 * //buffer_row_pitch// + //buffer_origin[0]//.
		 *
		 * @param host_origin The (x, y, z) offset in the memory region pointed to
		 * by ptr. For a 2D rectangle region, the z value given by
		 * //host_origin[2]// should be 0. The offset in bytes is computed as
		 * //host_origin[2]// * //host_slice_pitch// + //host_origin[1]// *
		 * //host_row_pitch// + //host_origin[0]//.
		 *
		 * @param region The (width, height, depth) in bytes of the 2D or 3D
		 * rectangle being read or written. For a 2D rectangle copy, the depth
		 * value given by //region[2]// should be 1.
		 *
		 * @param buffer_row_pitch The length of each row in bytes to be used for
		 * the memory region associated with buffer. If zero, its is computed as
		 * //region[0]//.
		 *
		 * @param buffer_slice_pitch The length of each 2D slice in bytes to be
		 * used for the memory region associated with buffer. If zero, it is
		 * computed as //region[1]// * //buffer_row_pitch//.
		 *
		 * @param host_row_pitch The length of each row in bytes to be used for the
		 * memory region pointed to by //ptr//. If zero, it is computed as
		 * //region[0]//.
		 *
		 * @param host_slice_pitch The length of each 2D slice in bytes to be used
		 * for the memory region pointed to by //ptr//. If zero, it is computed as
		 * //region[1]// * //host_row_pitch//.
		 *
		 * @param ptr The pointer to buffer in host memory where data is to be
		 * written from.
		 *
		 * @param event_wait_list The events that need to complete before this
		 * particular command can be executed. If null, then this particular
		 * command does not wait on any event to complete. The events specified act
		 * as synchronization points. The context associated with events and
		 * command queue must be the same.
		 *
		 * @param event Returns an event object that identifies this particular
		 * read command and can be used to query or queue a wait for this
		 * particular command to complete. If null, it will not be possible for the
		 * application to query the status of this command or queue a wait for this
		 * command to complete.
		 */
		[CCode(cname = "clEnqueueWriteBufferRect")]
		public Error enqueue_write_buffer_rect(Memory buffer, bool blocking_write, [CCode(array_length = false)] size_t[] buffer_origin, [CCode(array_length = false)] size_t[] host_origin, [CCode(array_length = false)] size_t[] region, size_t buffer_row_pitch, size_t buffer_slice_pitch, size_t host_row_pitch, size_t host_slice_pitch, void *ptr, [CCode(array_length_pos = 10.1)] Event[]? event_wait_list, out Event? event);

		/**
		 * Enqueues a command to write to a 2D or 3D image object from host memory.
		 *
		 * The command queue and image must be created with the same OpenCL context.
		 *
		 * Calling this method to update the latest bits in a region of the image
		 * with the //ptr// argument value set to //host_ptr// + (//origin[2]// *
		 * //image_slice_pitch// + //origin[1]// * //image_row_pitch// +
		 * //origin[0]// * //bytes_per_pixel//), where //host_ptr// is a pointer to
		 * the memory region specified when the image being written is created with
		 * {@link Memory.Flags.USE_HOST_PTR}, must meet the following requirements
		 * in order to avoid undefined behavior:<<BR>> The host memory region being
		 * written contains the latest bits when the enqueued write command begins
		 * execution.<<BR>> The //input_row_pitch// and //input_slice_pitch//
		 * argument values must be set to the image row pitch and slice
		 * pitch.<<BR>> The image object is not mapped.<<BR>> The image object is
		 * not used by any command-queue until the write command has finished
		 * execution.
		 *
		 * @param image Refers to a valid 2D or 3D image object.
		 *
		 * @param blocking_write Indicates if the write operation is blocking or
		 * non-blocking. If true, the OpenCL implementation copies the data
		 * referred to by ptr and enqueues the write command in the command queue.
		 * The memory pointed to by //ptr// can be reused by the application after
		 * the call returns. Otherwise, the OpenCL implementation will use //ptr//
		 * to perform a nonblocking write. As the write is non-blocking the
		 * implementation can return immediately. The memory pointed to by ptr
		 * cannot be reused by the application after the call returns. The event
		 * argument returns an event object which can be used to query the
		 * execution status of the write command. When the write command has
		 * completed, the memory pointed to by //ptr// can then be reused by the
		 * application.
		 *
		 * @param origin Defines the (x, y, z) offset in pixels in the image from
		 * where to write. If image is a 2D image object, the z value given by
		 * //origin[2]// must be 0.
		 *
		 * @param region Defines the (width, height, depth) in pixels of the 2D or
		 * 3D rectangle being written. If image is a 2D image object, the depth
		 * value given by //region[2]// must be 1.
		 *
		 * @param input_row_pitch The length of each row in bytes. This value must
		 * be greater than or equal to the element size in bytes times the width.
		 * If //input_row_pitch// is set to 0, the appropriate row pitch is
		 * calculated based on the size of each element in bytes multiplied by
		 * width.
		 *
		 * @param input_slice_pitch Size in bytes of the 2D slice of the 3D region
		 * of a 3D image being written. This must be 0 if image is a 2D image. This
		 * value must be greater than or equal to row_pitch times the height. If
		 * //input_slice_pitch// is set to 0, the appropriate slice pitch is
		 * calculated based on the row_pitch multiplied by the height.
		 *
		 * @param ptr The pointer to a buffer in host memory where image data is to
		 * be written to.
		 *
		 * @param event_wait_list Specify events that need to complete before this
		 * particular command can be executed. If null, then this particular
		 * command does not wait on any event to complete. The events specified act
		 * as synchronization points. The context associated with events and the
		 * command queue must be the same.
		 *
		 * @param event Returns an event object that identifies this particular
		 * write command and can be used to query or queue a wait for this
		 * particular command to complete. This can be null, in which case it will
		 * not be possible for the application to query the status of this command
		 * or queue a wait for this command to complete.
		 */
		[CCode(cname = "clEnqueueWriteImage")]
		public Error enqueue_write_image(Memory image, bool blocking_write, [CCode(array_length = false)] size_t[] origin, [CCode(array_length = false)] size_t[] region, size_t input_row_pitch, size_t input_slice_pitch, void* ptr, [CCode(array_length_pos = 7.1)] Event[]? event_wait_list, out Event? event);

		/**
		 * Blocks until all previously queued OpenCL commands in a command-queue are issued to the associated device and have completed.
		 */
		[CCode(cname = "clFinish")]
		public Error finish();

		/**
		 * Issues all previously queued OpenCL commands in a command-queue to the
		 * device associated with the command-queue.
		 *
		 * This method only guarantees that all queued commands get issued to the
		 * appropriate device. There is no guarantee that they will be complete
		 * after it returns.
		 *
		 * Any blocking commands queued in a command-queue perform an implicit
		 * flush of the command-queue. These blocking commands are {@link enqueue_read_buffer},
		 * {@link enqueue_read_buffer_rect}, or {@link enqueue_read_image} with
		 * //blocking_read// set to true; {@link enqueue_write_buffer},
		 * {@link enqueue_write_buffer_rect}, or {@link enqueue_write_image} with
		 * //blocking_write// set to true; {@link enqueue_map} or
		 * {@link enqueue_map_image} with //blocking_map// set to true; or
		 * {@link wait_for_events}.
		 *
		 * To use event objects that refer to commands enqueued in a command-queue
		 * as event objects to wait on by commands enqueued in a different
		 * command-queue, the application must call a {@link flush} or any blocking
		 * commands that perform an implicit flush of the command-queue where the
		 * commands that refer to these event objects are enqueued.
		 */
		[CCode(cname = "clFlush")]
		public Error flush();

		[CCode(cname = "clGetCommandQueueInfo")]
		public Error get_info(Info info, [CCode(array_length_pos = 1.1)] uint8[]? buffer, out size_t size);

		/**
		 * Call {@link get_info} with automatic space allocation.
		 */
		public Error get_info_auto(Info info, out uint8[]? buffer) {
			buffer = null;
			size_t size;
			Error err;
			if ((err = get_info(info, null, out size)) != Error.SUCCESS) {
				return err;
			}
			buffer = new uint8[size];
			return get_info(info, buffer, null);
		}

		[CCode(cname = "clSetCommandQueueProperty")]
		[Deprecated(since = "1.1")]
		public Error set_property(Properties properties, bool enable, out Properties? old_properties = null);
		/**
		 * Enqueues a wait for a specific event or a list of events to complete
		 * before any future commands queued in the command-queue are executed.
		 *
		 * @param events Events specified in act as synchronization points. The
		 * context associated with events and the command queue must be the same.
		 * Each event must be a valid event object returned by a previous call.
		 */
		[CCode(cname = "clEnqueueWaitForEvents")]
		public Error wait_for_events([CCode(array_length_pos = 0.1)] Event[] events);
	}

	[CCode(cname = "struct _cl_context", ref_function = "clRetainContext", unref_function = "clReleaseContext", ref_function_void = true, has_type_id = false)]
	public class Context {
		[CCode(cname = "cl_context_info", cprefix = "CL_CONTEXT_", has_type_id = false)]
		public enum Info {
			/**
			 * The context reference count. (uint)
			 *
			 * The reference count returned should be considered immediately stale.
			 * It is unsuitable for general use in applications. This feature is
			 * provided for identifying memory leaks.
			 */
			REFERENCE_COUNT,
			/**
			 * The list of devices in context. ({@link Device}[])
			 */
			DEVICES,
			/**
			 * The properties argument specified in {@link create} or {@link create_from_type}. (Properties[])
			 */
			PROPERTIES,
			/**
			 * Tthe number of devices in context. (uint)
			 */
			NUM_DEVICES,
			/**
			 * Whether sharing with Direct3D 10. (bool)
			 *
			 * If the cl_khr_d3d10_sharing extension is enabled, returns true if
			 * Direct3D 10 resources created as shared by setting MiscFlags to
			 * include D3D10_RESOURCE_MISC_SHARED will perform if aster when shared
			 * with OpenCL, compared with resources which have not set this flag.
			 */
			D3D10_PREFER_SHARED_RESOURCES_KHR
		}
		[CCode(cname = "cl_context_properties", cprefix = "CL_CONTEXT_", has_type_id = false)]
		public enum Properties {
			/**
			 * Specifies the platform to use. ({@link Platform})
			 */
			PLATFORM
		}

		[CCode(cname = "clCreateContext")]
		public static Context? create([CCode(array_length = false, array_null_terminated = true)] Properties[] properties, [CCode(array_length_pos = 1.1)] Device[] devices, Notify notify, out Error err);

		[CCode(cname = "clCreateContextFromType")]
		public static Context? create_from_type([CCode(array_length = false, array_null_terminated = true)]Properties[] properties, DeviceType type, Notify notify, out Error err);

		/**
		 * Creates a buffer object.
		 *
		 * @param flags Used to specify allocation and usage information such as
		 * the memory arena that should be used to allocate the buffer object and
		 * how it will be used.
		 *
		 * @param size The size in bytes of the buffer memory object to be
		 * allocated.
		 *
		 * @param host_ptr A pointer to the buffer data that may already be
		 * allocated by the application. The size of the buffer that host_ptr
		 * points to must be greater than or equal to the size bytes.
		*/
		[CCode(cname = "clCreateBuffer")]
		public Memory? create_buffer(Memory.Flags flags, size_t size, void* host, out Error err);

		/**
		 * Creates a 2D image object.
		 *
		 * @param flags Used to specify allocation and usage information about the
		 * image memory object being created.
		 *
		 * @param format A structure that describes format properties of the
		 * image to be allocated.
		 *
		 * @param width The width of the image, in pixels. Must be greater than or equal to 1.
		 *
		 * @param height The height of the image, in pixels. Must be greater than or equal to 1.
		 *
		 * @param row_pitch The scan-line pitch in bytes. This must be 0 if
		 * host_ptr is null and can be either 0 or greater than or equal to
		 * //width// * size of element in bytes if //host_ptr// is not null.  If
		 * //host_ptr// is not null and //row_pitch// is equal to 0, //row_pitch//
		 * is calculated as //width// * size of element in bytes. If //row_pitch//
		 * is not 0, it must be a multiple of the image element size in bytes.
		 *
		 * @param host_ptr A pointer to the image data that may already be
		 * allocated by the application. The size of the buffer that //host_ptr//
		 * points to must be greater than or equal to //row_pitch// * //height//.
		 * The size of each element in bytes must be a power of 2. The image data
		 * specified by //host_ptr// is stored as a linear sequence of adjacent
		 * scanlines. Each scanline is stored as a linear sequence of image
		 * elements.
		 */
		[CCode(cname = "clCreateImage2D")]
		public Memory? create_image_2d(Memory.Flags flags, image_format format, size_t width, size_t height, size_t row_pitch, void* host_ptr, out Error err);

		/**
		 * Creates a 3D image object.
		 *
		 * @param flags Used to specify allocation and usage information about the
		 * image memory object being created.
		 *
		 * @param format A structure that describes format properties of the
		 * image to be allocated.
		 *
		 * @param width The width of the image, in pixels. Must be greater than or equal to 1.
		 *
		 * @param height The height of the image, in pixels. Must be greater than or equal to 1.
		 *
		 * @param depth The depth of the image, in pixels. Must be greater than or equal to 1.
		 *
		 * @param row_pitch The scan-line pitch in bytes. This must be 0 if
		 * host_ptr is null and can be either 0 or greater than or equal to
		 * //width// * size of element in bytes if //host_ptr// is not null.  If
		 * //host_ptr// is not null and //row_pitch// is equal to 0, //row_pitch//
		 * is calculated as //width// * size of element in bytes. If //row_pitch//
		 * is not 0, it must be a multiple of the image element size in bytes.
		 *
		 * @param host_ptr A pointer to the image data that may already be
		 * allocated by the application. The size of the buffer that //host_ptr//
		 * points to must be greater than or equal to //row_pitch// * //height//.
		 * The size of each element in bytes must be a power of 2. The image data
		 * specified by //host_ptr// is stored as a linear sequence of adjacent
		 * scanlines. Each scanline is stored as a linear sequence of image
		 * elements.
		 * 
		 * @param slice_pitch The size in bytes of each 2D slice in the 3D image.
		 * This must be 0 if //host_ptr// is null and can be either 0 or greater
		 * than or equal to //row_pitch// * //height// if //host_ptr// is not null.
		 * If //host_ptr// is not null and //slice_pitch// equal to 0,
		 * //slice_pitch// is calculated as //row_pitch// * //height//. If
		 * //slice_pitch// is not 0, it must be a multiple of the //row_pitch//.
		 *
		 * @param host_ptr A pointer to the image data that may already be
		 * allocated by the application. The size of the buffer that //host_ptr//
		 * points to must be greater than or equal to //slice_pitch// * //depth//.
		 * The size of each element in bytes must be a power of 2. The image data
		 * specified by //host_ptr// is stored as a linear sequence of adjacent 2D
		 * slices. Each 2D slice is a linear sequence of adjacent scanlines. Each
		 * scanline is a linear sequence of image elements.
		 */
		[CCode(cname = "clCreateImage3D")]
		public Memory? create_image_3d(Memory.Flags flags, image_format format, size_t width, size_t height, size_t depth, size_t row_pitch, size_t slice_pitch, void* host_ptr, out Error err);

		/**
		 * Creates a program object for a context, and loads the binary bits
		 * specified by binary into the program object.
		 *
		 * OpenCL allows applications to create a program object using the program
		 * source or binary and build appropriate program executables. This allows
		 * applications to determine whether they want to use the pre-built offline
		 * binary or load and compile the program source and use the executable
		 * compiled/linked online as the program executable. This can be very
		 * useful as it allows applications to load and build program executables
		 * online on its first instance for appropriate OpenCL devices in the
		 * system. These executables can now be queried and cached by the
		 * application. Future instances of the application launching will no
		 * longer need to compile and build the program executables. The cached
		 * executables can be read and loaded by the application, which can help
		 * significantly reduce the application initialization time.
		 *
		 * The program binaries specified by binaries contain the bits that
		 * describe the program executable that will be run on the device(s)
		 * associated with context. The program binary can consist of either or
		 * both of device-specific executable(s), and/or implementation-specific
		 * intermediate representation (IR) which will be converted to the
		 * device-specific executable.
		 *
		 * @param devices A list of devices that are in this context. The binaries
		 * are loaded for devices specified in this list.
		 *
		 * @param lengths An array with the lengths of each //binaries//.
		 *
		 * @param binaries An array of program binaries to be loaded for devices
		 * specified. For each device given by //device_list[i]//, the pointer to
		 * the program binary for that device is given by binaries[i] and the
		 * length of this corresponding binary is given by //lengths[i]//.
		 *
		 * @param binary_status Returns whether the program binary for each device
		 * specified in device_list was loaded successfully or not. It is an array
		 * of the same length as //devices// entries and returns {@link Error.SUCCESS}
		 * in //binary_status[i]// if binary was successfully loaded for device
		 * specified by //device_list[i]//; otherwise returns {@link Error.INVALID_VALUE}
		 * if //lengths[i]// is zero or if //binaries[i]// is a null value or
		 * {@link Error.INVALID_BINARY} in //binary_status[i]// if program binary is
		 * not a valid binary for the specified device. If null, it is ignored.
		 *
		 * @param err Returns an appropriate error code.
		 */
		[CCode(cname = "clCreateProgramWithBinary")]
		public Program? create_program_with_binary([CCode(array_length_pos = 0.1)] Device[] devices, [CCode(array_length = false)] size_t[] lengths, [CCode(array_length = false)] uint8[][] binaries, [CCode(array_length = false)] Error[]? binary_status, out Error err);

		/**
		 * Creates a program object for a context, and loads the source code
		 * specified by the text strings in the strings array into the program
		 * object.
		 *
		 * The devices associated with the program object are the devices associated with context.
		 *
		 * OpenCL allows applications to create a program object using the program
		 * source or binary and build appropriate program executables. This allows
		 * applications to determine whether they want to use the pre-built offline
		 * binary or load and compile the program source and use the executable
		 * compiled/linked online as the program executable. This can be very
		 * useful as it allows applications to load and build program executables
		 * online on its first instance for appropriate OpenCL devices in the
		 * system. These executables can now be queried and cached by the
		 * application. Future instances of the application launching will no
		 * longer need to compile and build the program executables. The cached
		 * executables can be read and loaded by the application, which can help
		 * significantly reduce the application initialization time.
		 *
		 * An OpenCL program consists of a set of kernels that are identified as
		 * functions declared with the _\_kernel qualifier in the program source.
		 * OpenCL programs may also contain auxiliary functions and constant data
		 * that can be used by _\_kernel functions. The program executable can be
		 * generated online or offline by the OpenCL compiler for the appropriate
		 * target device(s).
		 *
		 * @param strings An optionally null-terminated character strings that make up the source code.
		 *
		 * @param lengths An array with the number of chars in each string (the
		 * string length). If an element in lengths is zero, its accompanying
		 * string is null-terminated. If lengths is null, all strings in the
		 * strings argument are considered null-terminated. Any length value passed
		 * in that is greater than zero excludes the null terminator in its count.
		 */
		[CCode(cname = "clCreateProgramWithSource")]
		public Program? create_program_with_source([CCode(array_length_pos = 0.1)] string[] strings, [CCode(array_length = false)] size_t[]? lengths, out Error err);

		[CCode(cname = "clCreateCommandQueue")]
		public CommandQueue? create_queue(Device device, CommandQueue.Properties properties, out Error err);

		/**
		 * Creates a user event object.
		 *
		 * User events allow applications to enqueue commands that wait on a user
		 * event to finish before the command is executed by the device.
		 *
		 * The execution status of the user event object created is set to {@link Event.Status.SUBMITTED}.
		 */
		[CCode(cname = "clCreateUserEvent")]
		public Event create_user_Event(out Error? error = null);

		/**
		 * Get the list of image formats supported by an OpenCL implementation.
		 *
		 * @param flags The allocation and usage information about the image memory
		 * object being created
		 *
		 * @param image_type Describes the image type and must be either
		 * {@link Memory.ObjectType.IMAGE2D} or {@link Memory.ObjectType.IMAGE3D}.
		 *
		 * @param formats Where the list of supported image formats are returned.
		 * Each entry describes a structure supported by the OpenCL implementation.
		 * If null, it is ignored.
		 *
		 * @param count The actual number of supported image formats for a specific
		 * context and values specified by flags. If null, it is ignored.
		 */
		[CCode(cname = "clGetSupportedImageFormats")]
		public Error get_image_formats(Memory.Flags flags, Memory.ObjectType image_type, [CCode(array_length_pos = 2.1)] image_format[]? formats, out uint count);

		[CCode(cname = "clGetContextInfo")]
		public Error get_info(Info info, [CCode(array_length_pos = 1.1)] uint8[]? buffer, out size_t size);
		/**
		 * Call {@link get_info} with automatic space allocation.
		 */
		public Error get_info_auto(Info info, out uint8[]? buffer) {
			buffer = null;
			size_t size;
			Error err;
			if ((err = get_info(info, null, out size)) != Error.SUCCESS) {
				return err;
			}
			buffer = new uint8[size];
			return get_info(info, buffer, null);
		}

	}

	[CCode(cname = "cl_device_info", cprefix = "CL_DEVICE_", has_type_id = false)]
	public enum DeviceInfo {
		TYPE,
		VENDOR_ID,
		MAX_COMPUTE_UNITS,
		MAX_WORK_ITEM_DIMENSIONS,
		MAX_WORK_GROUP_SIZE,
		MAX_WORK_ITEM_SIZES,
		PREFERRED_VECTOR_WIDTH_CHAR,
		PREFERRED_VECTOR_WIDTH_SHORT,
		PREFERRED_VECTOR_WIDTH_INT,
		PREFERRED_VECTOR_WIDTH_LONG,
		PREFERRED_VECTOR_WIDTH_FLOAT,
		PREFERRED_VECTOR_WIDTH_DOUBLE,
		MAX_CLOCK_FREQUENCY,
		ADDRESS_BITS,
		MAX_READ_IMAGE_ARGS,
		MAX_WRITE_IMAGE_ARGS,
		MAX_MEM_ALLOC_SIZE,
		IMAGE2D_MAX_WIDTH,
		IMAGE2D_MAX_HEIGHT,
		IMAGE3D_MAX_WIDTH,
		IMAGE3D_MAX_HEIGHT,
		IMAGE3D_MAX_DEPTH,
		IMAGE_SUPPORT,
		MAX_PARAMETER_SIZE,
		MAX_SAMPLERS,
		MEM_BASE_ADDR_ALIGN,
		MIN_DATA_TYPE_ALIGN_SIZE,
		SINGLE_FP_CONFIG,
		GLOBAL_MEM_CACHE_TYPE,
		GLOBAL_MEM_CACHELINE_SIZE,
		GLOBAL_MEM_CACHE_SIZE,
		GLOBAL_MEM_SIZE,
		MAX_CONSTANT_BUFFER_SIZE,
		MAX_CONSTANT_ARGS,
		LOCAL_MEM_TYPE,
		LOCAL_MEM_SIZE,
		ERROR_CORRECTION_SUPPORT,
		PROFILING_TIMER_RESOLUTION,
		ENDIAN_LITTLE,
		AVAILABLE,
		COMPILER_AVAILABLE,
		EXECUTION_CAPABILITIES,
		QUEUE_PROPERTIES,
		NAME,
		VENDOR,
		VERSION,
		PROFILE,
		[CCode(cname = "CL_DRIVER_VERSION")]
		DRIVER_VERSION,
		EXTENSIONS,
		PLATFORM,
		PREFERRED_VECTOR_WIDTH_HALF,
		HOST_UNIFIED_MEMORY,
		NATIVE_VECTOR_WIDTH_CHAR,
		NATIVE_VECTOR_WIDTH_SHORT,
		NATIVE_VECTOR_WIDTH_INT,
		NATIVE_VECTOR_WIDTH_LONG,
		NATIVE_VECTOR_WIDTH_FLOAT,
		NATIVE_VECTOR_WIDTH_DOUBLE,
		NATIVE_VECTOR_WIDTH_HALF,
		OPENCL_C_VERSION
	}

	[CCode(cname = "cl_device_exec_capabilities", cprefix = "CL_EXEC_", has_type_id = false)]
	public enum ExecutionCapabilities {
		KERNEL,
		NATIVE_KERNEL
	}

	[CCode(cname = "cl_device_fp_config", cprefix = "CL_FP_", has_type_id = false)]
	public enum FloatingPointConfig {
		DENORM,
		FMA,
		INF_NAN,
		ROUND_TO_INF,
		ROUND_TO_NEAREST,
		ROUND_TO_ZERO
	}

	[CCode(cname = "cl_device_local_mem_type", cprefix = "CL_", has_type_id = false)]
	public enum LocalMemoryType {
		GLOBAL,
		LOCAL
	}

	[CCode(cname = "cl_device_mem_cache_type", cprefix = "CL_", has_type_id = false)]
	public enum MemoryCacheType {
		NONE,
		READ_ONLY_CACHE,
		READ_WRITE_CACHE
	}

	[CCode(cname = "cl_device_type", cprefix = "CL_DEVICE_TYPE_", has_type_id = false)]
	[Flags]
	public enum DeviceType {
		/**
		 * The default OpenCL device in the system.
		 */
		DEFAULT,
		/**
		 * An OpenCL device that is the host processor.
		 *
		 * The host processor runs the OpenCL implementations and is a single or multi-core CPU.
		 */
		CPU,
		/**
		 * An OpenCL device that is a GPU.
		 *
		 * By this we mean that the device can also be used to accelerate a 3D
		 * API such as OpenGL or DirectX.
		 */
		GPU,
		/**
		 * Dedicated OpenCL accelerators (for example the IBM CELL Blade).
		 *
		 * These devices communicate with the host processor using a peripheral
		 * interconnect such as PCIe.
		 */
		ACCELERATOR,
#if OPENCL12
		/**
		 * Dedicated accelerators that do not support programs written in OpenCL C.
		 */
		CUSTOM,
#endif
		/**
		 * All OpenCL devices available in the system.
		 */
		ALL
	}

	[CCode(cname = "cl_device_id", has_type_id = false)]
	[SimpleType]
	public struct Device {
		[CCode(cname = "clGetDeviceInfo")]
		public Error get_info(DeviceInfo info, [CCode(array_length_pos = 1.1)] uint8[]? buffer, out size_t size);

		/**
		 * Call {@link get_info} with automatic space allocation.
		 */
		public Error get_info_auto(DeviceInfo info, out uint8[]? buffer) {
			buffer = null;
			size_t size;
			Error err;
			if ((err = get_info(info, null, out size)) != Error.SUCCESS) {
				return err;
			}
			buffer = new uint8[size];
			return get_info(info, buffer, null);
		}

	}

	[CCode(cname = "struct _cl_event", ref_function = "clRetainEvent", unref_function = "clReleaseEvent", ref_function_void = true, has_type_id = false)]
	public class Event {
		[CCode(cname = "cl_event_info", cprefix = "CL_EVENT_")]
		public enum Info {
			/**
			 * The command-queue associated with event. ({@link CommandQueue})
			 *
			 * For user event objects, a null value is returned.
			 */
			COMMAND_QUEUE,
			/**
			 * The context associated with event. ({@link Context})
			 */
			CONTEXT,
			/**
			 * The command associated with event. ({@link CommandType})
			 */
			COMMAND_TYPE,
			/**
			 * The execution status of the command identified by event. ({@link State} or {@link Error})
			 */
			COMMAND_EXECUTION_STATUS,
			/**
			 * The event reference count. (uint)
			 *
			 * The reference count returned should be considered immediately stale.
			 * It is unsuitable for general use in applications. This feature is
			 * provided for identifying memory leaks.
			 */
			REFERENCE_COUNT
		}
		[CCode(cname = "cl_profiling_info", cprefix = "CL_PROFILING_COMMAND_", has_type_id = false)]
		public enum State {
			/**
			 * The current device time counter in nanoseconds when the command
			 * identified by event is enqueued in a command-queue by the host.
			 * (uint64)
			 */
			QUEUED,
			/**
			 * The current device time counter in nanoseconds when the command
			 * identified by event that has been enqueued is submitted by the host to
			 * the device associated with the command-queue. (uint64)
			 */
			SUBMIT,
			/**
			 * The current device time counter in nanoseconds when the command
			 * identified by event starts execution on the device. (uint64)
			 */
			START,
			/**
			 * The current device time counter in nanoseconds when the command
			 * identified by event has finished execution on the device. (uint64)
			 */
			END
		}
		[CCode(cname = "cl_int", cprefix = "CL_", has_type_id = false)]
		public enum Status {
			COMPLETE,
			RUNNING,
			SUBMITTED,
			QUEUED
		}
#if 0
		public callback {
			[CCode(cname = "clSetEventCallback")]
			set(Status status);
		}
		 //TODO
cl_int clSetEventCallback (	cl_event event,
 	cl_int  command_exec_callback_type ,
 	void (CL_CALLBACK  *pfn_event_notify) (cl_event event, cl_int event_command_exec_status, void *user_data),
 	void *user_data)
#endif

		[CCode(cname = "clGetEventInfo")]
		public Error get_info(Info info, [CCode(array_length_pos = 1.1)] uint8[]? buffer, out size_t size);
		/**
		 * Call {@link get_info} with automatic space allocation.
		 */
		public Error get_info_auto(Info info, out uint8[]? buffer) {
			buffer = null;
			size_t size;
			Error err;
			if ((err = get_info(info, null, out size)) != Error.SUCCESS) {
				return err;
			}
			buffer = new uint8[size];
			return get_info(info, buffer, null);
		}

		[CCode(cname = "clGetEventProfilingInfo")]
		public Error get_profiling_info(State state, [CCode(array_length_pos = 1.1)] uint8[]? buffer, out size_t size);

		/**
		 * Call {@link get_profiling_info} with automatic space allocation.
		 */
		public Error get_profiling_info_auto(State state, out uint8[]? buffer) {
			buffer = null;
			size_t size;
			Error err;
			if ((err = get_profiling_info(state, null, out size)) != Error.SUCCESS) {
				return err;
			}
			buffer = new uint8[size];
			return get_profiling_info(state, buffer, null);
		}

		/**
		 * Sets the execution status of a user event object.
		 *
		 * Can only be called once.
		 */
		[CCode(cname = "clSetUserEventStatus")]
		public Memory complete(Status status = Status.COMPLETE);

		/**
		 * Sets the execution status of a user event object.
		 *
		 * Can only be called once. All enqueued commands that wait on this user event will be terminated.
		 */
		[CCode(cname = "clSetUserEventStatus")]
		public Memory set_error(Error err);
	}
	[CCode(cname = "struct _cl_kernel", ref_function = "clRetainKernel", unref_function = "clReleaseKernel", ref_function_void = true, has_type_id = false)]
	public class Kernel {
		[CCode(cname = "cl_kernel_info", cprefix = "CL_KERNEL_", has_type_id = false)]
		public enum Info {
			/**
			 * The kernel function name. (char[])
			 */
			FUNCTION_NAME,
			/**
			 * The number of arguments to kernel. (uint)
			 */
			NUM_ARGS,
			/**
			 * The kernel reference count. (uint)
			 *
			 * The reference count returned should be considered immediately stale.
			 * It is unsuitable for general use in applications. This feature is
			 * provided for identifying memory leaks.
			 */
			REFERENCE_COUNT,
			/**
			 * The context associated with kernel. ({@link Context})
			 */
			CONTEXT,
			/**
			 * The program object associated with kernel. (@link Program})
			 */
			PROGRAM
		}

		[CCode(cname = "cl_kernel_work_group_info", has_type_id = false)]
		public enum WorkgroupInfo {
			/**
			 * The maximum work-group size that can be used to execute a kernel on a
			 * specific device given by device. (size_t)
			 *
			 * The OpenCL implementation uses the resource requirements of the kernel
			 * (register usage etc.) to determine what this work-group size should
			 * be.
			 */
			[CCode(cname = "CL_KERNEL_WORK_GROUP_SIZE")]
			SIZE,
			/**
			 * The work-group size specified by the
			 * _\_attribute_\_((reqd_work_group_size(X, Y, Z))) qualifier. (size_t[3])
			 *
			 * If the work-group size is not specified using the above attribute
			 * qualifier (0, 0, 0) is returned.
			 */
			[CCode(cname = "CL_KERNEL_COMPILE_WORK_GROUP_SIZE")]
			COMPILE_SIZE,
			/**
			 * The amount of local memory in bytes being used by a kernel. (ulong)
			 *
			 * This includes local memory that may be needed by an implementation to
			 * execute the kernel, variables declared inside the kernel with the
			 * _\_local address qualifier and local memory to be allocated for
			 * arguments to the kernel declared as pointers with the _\_local address
			 * qualifier and whose size is specified with {@link set_arg_raw}.
			 *
			 * If the local memory size, for any pointer argument to the kernel
			 * declared with the _\_local address qualifier, is not specified, its
			 * size is assumed to be 0.
			 */
			[CCode(cname = "CL_KERNEL_LOCAL_MEM_SIZE")]
			LOCAL_MEM_SIZE,
			/**
			 * The preferred multiple of workgroup size for launch. (size_t)
			 *
			 * This is a performance hint. Specifying a workgroup size that is not a
			 * multiple of the value returned by this query as the value of the local
			 * work size argument to {@link CommandQueue.enqueue_range} not fail to
			 * enqueue the kernel for execution unless the work-group size specified
			 * is larger than the device maximum.
			 */
			[CCode(cname = "CL_KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE")]
			PREFERRED_SIZE_MULTIPLE,
			/**
			 * Returns the minimum amount of private memory, in bytes, used by each
			 * workitem in the kernel. (ulong)
			 *
			 * This value may include any private memory needed by an implementation to
			 * execute the kernel, including that used by the language built-ins and
			 * variable declared inside the kernel with the _\_private qualifier.
			 */
			[CCode(cname = "CL_KERNEL_PRIVATE_MEM_SIZE")]
			PRIVATE_MEM_SIZE
		}

		public Error get_info(Info info, [CCode(array_length_pos = 1.1)] uint8[]? buffer, out size_t size);
		/**
		 * Call {@link get_info} with automatic space allocation.
		 */
		public Error get_info_auto(Info info, out uint8[]? buffer) {
			buffer = null;
			size_t size;
			Error err;
			if ((err = get_info(info, null, out size)) != Error.SUCCESS) {
				return err;
			}
			buffer = new uint8[size];
			return get_info(info, buffer, null);
		}

		/**
		 * Returns information about the kernel object that may be specific to a device.
		 *
		 * @param device Identifies a specific device in the list of devices
		 * associated with kernel. The list of devices is the list of devices in
		 * the OpenCL context that is associated with kernel. If the list of
		 * devices associated with kernel is a single device, device can be null.
		 */
		[CCode(cname = "clGetKernelWorkGroupInfo")]
		public Error get_workgroup_info(Device? device, WorkgroupInfo info, [CCode(array_length_pos = 1.1)] uint8[]? buffer, out size_t size);

		/**
		 * Call {@link get_workgroup_info} with automatic space allocation.
		 */
		public Error get_workgroup_info_auto(Device? device, WorkgroupInfo info, out uint8[]? buffer) {
			buffer = null;
			size_t size;
			Error err;
			if ((err = get_workgroup_info(device, info, null, out size)) != Error.SUCCESS) {
				return err;
			}
			buffer = new uint8[size];
			return get_workgroup_info(device, info, buffer, null);
		}

		/**
		 * Used to set the argument value for a specific argument of a kernel.
		 *
		 * A kernel object does not update the reference count for objects such as
		 * memory, sampler objects specified as argument values by clSetKernelArg.
		 * Users may not rely on a kernel object to retain objects specified as
		 * argument values to the kernel.
		 *
		 * Implementations shall not allow {@link Kernel} objects to hold reference
		 * counts to kernel arguments, because no mechanism is provided for the
		 * user to tell the kernel to release that ownership right. If the kernel
		 * holds ownership rights on kernel args, that would make it impossible for
		 * the user to tell with certainty when he may safely release user
		 * allocated resources associated with OpenCL objects such as the
		 * {@link Memory} backing store used with {@link Memory.Flags.USE_HOST_PTR}.
		 *
		 * An OpenCL API call is considered to be thread-safe if the internal state
		 * as managed by OpenCL remains consistent when called simultaneously by
		 * multiple host threads. OpenCL API calls that are thread-safe allow an
		 * application to call these functions in multiple host threads without
		 * having to implement mutual exclusion across these host threads i.e. they
		 * are also re-entrant-safe.
		 *
		 * All OpenCL API calls are thread-safe except clSetKernelArg, which is
		 * safe to call from any host thread, and is safe to call re-entrantly so
		 * long as concurrent calls operate on different kernel objects.
		 * However, the behavior of the kernel object is undefined if
		 * this method is called from multiple host threads on the same
		 * object at the same time.
		 *
		 * There is an inherent race condition in the design of OpenCL that occurs
		 * between setting a kernel argument and using the kernel with
		 * {@link CommandQueue.enqueue_range} or {@link CommandQueue.enqueue_task}.
		 * Another host thread might change the kernel arguments between when a
		 * host thread sets the kernel arguments and then enqueues the kernel,
		 * causing the wrong kernel arguments to be enqueued. Rather than attempt
		 * to share kernel objects among multiple host threads, applications are
		 * strongly encouraged to make additional kernel objects for kernel
		 * functions for each host thread.
		 *
		 * If the argument is a memory object (buffer or image), the arg_value
		 * entry will be a pointer to the appropriate buffer or image object. The
		 * memory object must be created with the context associated with the
		 * kernel object. A null value can also be specified if the argument is a
		 * buffer object in which case a null value will be used as the value for
		 * the argument declared as a pointer to _\_global or _\_constant memory in
		 * the kernel. If the argument is declared with the _\_local qualifier, the
		 * arg_value entry must be null. If the argument is of type sampler_t, the
		 * arg_value entry must be a pointer to the sampler object.
		 *
		 * If the argument is declared to be a pointer of a built-in or user
		 * defined type with the _\_global or _\_constant qualifier, the memory
		 * object specified as argument value must be a buffer object (or null). If
		 * the argument is declared with the _\_constant qualifier, the size in
		 * bytes of the memory object cannot exceed {@link DeviceInfo.MAX_CONSTANT_BUFFER_SIZE}
		 * and the number of arguments declared with the _\_constant qualifier
		 * cannot exceed {@link DeviceInfo.MAX_CONSTANT_ARGS}.
		 *
		 * For all other kernel arguments, the arg_value entry must be a pointer to
		 * the actual data to be used as argument value.
		 *
		 * @param index The argument index. Arguments to the kernel are referred by
		 * indices that go from 0 for the leftmost argument to n - 1, where n is
		 * the total number of arguments declared by a kernel.
		 *
		 * @param arg_value A pointer to data that should be used as the argument
		 * value for argument specified by arg_index. The argument data pointed to
		 * by arg_value is copied and the arg_value pointer can therefore be reused
		 * by the application after this method returns. The argument value
		 * specified is the value used by all API calls that enqueue kernel
		 * ({@link CommandQueue.enqueue_range} and {@link CommandQueue.enqueue_task})
		 * until the argument value is changed by a call to this method for kernel.
		 *
		 * @param arg_size Specifies the size of the argument value. If the
		 * argument is a memory object, the size is the size of the buffer or image
		 * object type. For arguments declared with the _\_local qualifier, the size
		 * specified will be the size in bytes of the buffer that must be allocated
		 * for the _\_local argument. If the argument is of type sampler_t, the
		 * arg_size value must be equal to sizeof(cl_sampler). For all other
		 * arguments, the size will be the size of argument type.
		 */
		[CCode(cname = "clSetKernelArg")]
		public Error set_arg_raw(uint index, size_t arg_size, void* arg_value);
		[CCode(cname = "clSetKernelArg")]
		public Error set_arg_data(uint index, [CCode(array_length_pos = 1.1)] uint8[] value);
		public Error set_arg_memory(uint index, Memory mem) {
			size_t size;
			uint8[] size_array = (uint8[]) size;
			size_array.length = (int)sizeof(size_t);
			Error err = mem.get_info(Memory.Info.SIZE, size_array, null);
			return err == Error.SUCCESS ? set_arg_raw(index, size, mem) : err;
		}
		public Error set_arg_sampler(uint index, Sampler sampler) {
			return set_arg_raw(index, sizeof(Sampler), sampler);
		}

	}
	[CCode(cname = "struct _cl_mem", ref_function = "clRetainMemObject", unref_function = "clReleaseMemObject", ref_function_void = true, has_type_id = false)]
	public class Memory {
		public Notify destructor_callback {
			[CCode(cname = "clSetMemObjectDestructorCallback")]
			public set;
		}
		[CCode(cname = "cl_mem_info", cprefix = "CL_MEM_", has_type_id = false)]
		public enum Info {
			/**
			 * The type. ({@link ObjectType})
			 */
			TYPE,
			/**
			 * The flags argument value specified when memobj is created. ({@link Flags})
			 */
			FLAGS,
			/**
			 * The actual size of the data store associated with object in bytes. (size_t)
			 */
			SIZE,
			/**
			 * The //host_ptr// argument value specified when object is created. (void*)
			 */
			HOST_PTR,
			/**
			 * Map count. (uint)
			 *
			 * The map count returned should be considered immediately stale. It is
			 * unsuitable for general use in applications. This feature is provided
			 * for debugging.
			 */
			MAP_COUNT,
			/**
			 * Reference count. (uint)
			 *
			 * The reference count returned should be considered immediately stale.
			 * It is unsuitable for general use in applications. This feature is
			 * provided for identifying memory leaks.
			 */
			REFERENCE_COUNT,
			/**
			 * The context specified when memory object is created. ({@link Context})
			 */
			CONTEXT,
			/**
			 * The memory object from which this object is created. ({@link Memory}?)
			 *
			 * This is the memory object specified as buffer argument to {@link create_subbuffer}.
			 *
			 * Otherwise, null is returned.
			 */
			ASSOCIATED_MEMOBJECT,
			/**
			 * The offset, if the object is a sub-buffer object created using
			 * {@link create_subbuffer}. (size_t)
			 *
			 * This is zero if not a subbuffer object.
			 */
			OFFSET
		}

		[CCode(cname = "cl_image_info", cprefix = "CL_IMAGE_", has_type_id = false)]
		public enum ImageInfo {
			/**
			 * Image format descriptor specified when image is created. ({@link image_format})
			 */
			FORMAT,
			/**
			 * The size of each element of the image memory object. (size_t)
			 *
			 * An element is made up of //n// channels. The value of //n// is given
			 * in {@link image_format} descriptor.
			 */
			ELEMENT_SIZE,
			/**
			 * The size in bytes of a row of elements of the image object. (size_t)
			 */
			ROW_PITCH,
			/**
			 * The size in bytes of a 2D slice for the 3D image object. (size_t)
			 *
			 * For a 2D image object this value will be 0.
			 */
			SLICE_PITCH,
			/**
			 * The width of image in pixels. (size_t)
			 */
			WIDTH,
			/**
			 * The height of image in pixels. (size_t)
			 */
			HEIGHT,
			/**
			 * The depth of image in pixels. (size_t)
			 *
			 * For a 2D image object this value will be 0.
			 */
			DEPTH
		}
		[CCode(cname = "cl_mem_flags", cprefix = "CL_MEM_", has_type_id = false)]
		[Flags]
		public enum Flags {
			/**
			 * The memory object will be read and written by a kernel. This is the default.
			 */
			READ_WRITE,
			/**
			 * A memory object will be written but not read by a kernel.
			 *
			 * Reading from a buffer or image object created with this flag inside a
			 * kernel is undefined.
			 */
			WRITE_ONLY,
			/**
			 * A memory object is a read-only memory object when used inside a
			 * kernel.
			 *
			 * Writing to a buffer or image object created with this flag inside a
			 * kernel is undefined.
			 */
			READ_ONLY,
			/**
			 * The application wants the OpenCL implementation to use memory
			 * referenced by //host_ptr// as the storage bits for the memory object.
			 *
			 * OpenCL implementations are allowed to cache the buffer contents
			 * pointed to by //host_ptr// in device memory. This cached copy can be
			 * used when kernels are executed on a device.
			 *
			 * The result of OpenCL commands that operate on multiple buffer objects
			 * created with the same host_ptr or overlapping host regions is
			 * considered to be undefined.
			 *
			 * This flag is valid only if //host_ptr// is not null.
			 */
			USE_HOST_PTR,
			/**
			 * The application wants the OpenCL implementation to allocate memory
			 * from host accessible memory.
			 *
			 * Cannot be combined with {@link USE_HOST_PTR}.
			 */
			ALLOC_HOST_PTR,
			/**
			 * The application wants the OpenCL implementation to allocate memory for
			 * the memory object and copy the data from memory referenced by
			 * //host_ptr//.
			 *
			 * This flag can be used with {@link ALLOC_HOST_PTR} to initialize the
			 * contents of a {@link Memory} object allocated using host-accessible
			 * (e.g. PCIe) memory.
			 *
			 * This flag is valid only if //host_ptr// is not null.
			 *
			 * Cannot be combined with {@link USE_HOST_PTR}.
			 */
			COPY_HOST_PTR
		}
		[CCode(cname = "cl_buffer_create_type", cprefix = "CL_BUFFER_CREATE_TYPE_", has_type_id = false)]
		public enum CreationType {
			REGION
		}
		[CCode(cname = "cl_mem_object_type", cprefix = "CL_MEM_OBJECT_", has_type_id = false)]
		public enum ObjectType {
			BUFFER,
			IMAGE2D,
			IMAGE3D
		}

		/**
		 * Creates a buffer object (referred to as a sub-buffer object) from an existing buffer object.
		 *
		 * This method cannot be called on an already sub-buffered object.
		 *
		 * @param type If {@link CreationType.REGION}, which create a buffer object
		 * that represents a specific region in buffer, //info// must be
		 * {@link buffer_region}.
		 */
		[CCode(cname = "clCreateSubBuffer")]
		public Memory? create_subbuffer(Memory.Flags flags, CreationType type, buffer_create_info info, out Error err);
		/**
		 * Get specific information about the OpenCL memory.
		 * @param buffer where the information will be stored
		 * @param size the size of the information stored, in bytes
		 */
		[CCode(cname = "clGetMemObjectInfo")]
		public Error get_info(Info info, [CCode(array_length_pos = 1.1)] uint8[]? buffer, out size_t size);
		/**
		 * Call {@link get_info} with automatic space allocation.
		 */
		public Error get_info_auto(Info info, out uint8[]? buffer) {
			buffer = null;
			size_t size;
			Error err;
			if ((err = get_info(info, null, out size)) != Error.SUCCESS) {
				return err;
			}
			buffer = new uint8[size];
			return get_info(info, buffer, null);
		}
		/**
		 * Get specific information about the OpenCL memory.
		 * @param buffer where the information will be stored
		 * @param size the size of the information stored, in bytes
		 */
		[CCode(cname = "clGetMemObjectInfo")]
		public Error get_image_info(ImageInfo info, [CCode(array_length_pos = 1.1)] uint8[]? buffer, out size_t size);
		/**
		 * Call {@link get_info} with automatic space allocation.
		 */
		public Error get_image_info_auto(ImageInfo info, out uint8[]? buffer) {
			buffer = null;
			size_t size;
			Error err;
			if ((err = get_image_info(info, null, out size)) != Error.SUCCESS) {
				return err;
			}
			buffer = new uint8[size];
			return get_image_info(info, buffer, null);
		}
	}

	[CCode(cname = "cl_platform_info", cprefix = "CL_PLATFORM_", has_type_id = false)]
	public enum PlatformInfo {
		/**
		 * OpenCL profile string. Returns the profile name supported by the implementation.
		 *
		 * The profile name returned can be one of the following strings:
		 *
		 * FULL_PROFILE - if the implementation supports the OpenCL specification (functionality defined as part of the core specification and does not require any extensions to be supported).
		 *
		 * EMBEDDED_PROFILE - if the implementation supports the OpenCL embedded profile. The embedded profile is defined to be a subset for each version of OpenCL.
		 */
		PROFILE,
		/**
		 * The OpenCL version supported by the implementation.
		 *
		 * This version string has the following format:
		 *
		 * OpenCL<space><major_version.minor_version><space><platform-specific information>
		 *
		 * The major_version.minor_version value returned will be 1.2.
		 */
		VERSION,
		NAME,
		VENDOR,
		/**
		 * A space-separated list of extension names (the extension names themselves do not contain any spaces) supported by the platform.
		 *
		 * Extensions defined here must be supported by all devices associated with this platform.
		 */
		EXTENSIONS
	}
	[CCode(cname = "cl_platform_id", has_type_id = false)]
	[SimpleType]
	public struct Platform {

		/**
		 * Obtain the list of devices available on a platform.
		 */
		[CCode(cname = "clGetDeviceIDs")]
		public Error get_devices(DeviceType type, [CCode(array_length_pos = 1.1)] Device[]? devices, out uint count);

		/**
		 * Obtain the list of platforms available.
		 * @param count the number of platforms placed in the array
		 */
		[CCode(cname = "clGetPlatformIDs")]
		public static Error get_ids([CCode(array_length_pos = 0)] Platform[]? platforms, out int count);
		/**
		 * Get specific information about the OpenCL platform.
		 * @param buffer where the information will be stored
		 * @param size the size of the information stored, in bytes
		 */
		[CCode(cname = "clGetPlatformInfo")]
		public Error get_info(PlatformInfo info, [CCode(array_length_pos = 1.1)] uint8[]? buffer, out size_t size);
		/**
		 * Call {@link get_info} with automatic space allocation.
		 */
		public Error get_info_auto(PlatformInfo info, out uint8[]? buffer) {
			buffer = null;
			size_t size;
			Error err;
			if ((err = get_info(info, null, out size)) != Error.SUCCESS) {
				return err;
			}
			buffer = new uint8[size];
			return get_info(info, buffer, null);
		}
	}

	[CCode(cname = "struct _cl_program", ref_function = "clRetainProgram", unref_function = "clReleaseProgram", ref_function_void = true, has_type_id = false)]
	public class Program {
		[CCode(cname = "cl_program_build_info", cprefix = "CL_PROGRAM_BUILD_", has_type_id = false)]
		public enum BuildInfo {
			/**
			 * The build status of program for a specific device as given by device. (@{link BuildStatus})
			 */
			STATUS,
			/**
			 * The build options specified by the options argument when {@link build}
			 * was called for device. (string)
			 *
			 * If build status of program for device is {@link BuildStatus.NONE}, an
			 * empty string is returned.
			 */
			OPTIONS,
			/**
			 * The build log when {@link build} was called for device. (string)
			 *
			 * If build status of program for device is {@link BuildStatus.NONE}, an
			 * empty string is returned.
			 */
			LOG
		}
		[CCode(cname = "cl_build_status", cprefix = "CL_BUILD_", has_type_id = false)]
		public enum BuildStatus {
			/**
			 * No build has been performed on the specified program object for device.
			 */
			NONE,
			/**
			 * The last call to {@link build} on the specified program object for
			 * device generated an error.
			 */
			ERROR,
			/**
			 * The last call to {@link build} on the specified program object for
			 * device was successful.
			 */
			SUCCESS,
			/**
			 * The last call to {@link build} on the specified program object for
			 * device has not finished.
			 */
			IN_PROGRESS
		}
		[CCode(cname = "cl_program_info", cprefix = "CL_PROGRAM_", has_type_id = false)]
		public enum Info {
			/**
			 * The program reference count. (uint)
			 *
			 * The reference count returned should be considered immediately stale.
			 * It is unsuitable for general use in applications. This feature is
			 * provided for identifying memory leaks.
			 */
			REFERENCE_COUNT,
			/**
			 * The context specified when the program object is created ({@link Context}).
			 */
			CONTEXT,
			/**
			 * The number of devices associated with program. (uint)
			 */
			NUM_DEVICES,
			/**
			 * The list of devices associated with the program object. ({@link Device}[])
			 *
			 * This can be the devices associated with context on which the program
			 * object has been created or can be a subset of devices that are
			 * specified when a progam object is created using
			 * {@link Context.create_program_with_binary}.
			 */
			DEVICES,
			/**
			 * The program source code specified by {@link Context.create_program_with_source}. (char[])
			 *
			 * The source string returned is a concatenation of all source strings
			 * specified. The concatenation strips any nulls in the original source
			 * strings.
			 *
			 * The actual number of characters that represents the program source
			 * code including the null terminator is returned in the length.
			 */
			SOURCE,
			/**
			 * An array that contains the size in bytes of the program binary for
			 * each device associated with program.  (size_t[])
			 *
			 * The size of the array is the number of devices associated with
			 * program.  If a binary is not available for a device(s), a size of zero
			 * is returned.
			 */
			BINARY_SIZES,
			/**
			 * The program binaries for all devices associated with program. (uint8[])
			 *
			 * For each device in program, the binary returned can be the binary
			 * specified for the device when program is created with
			 * {@link Context.create_program_with_binary} or it can be the executable binary
			 * generated by {@link Program.build}. If program is created with
			 * {@link Context.create_program_with_source}, the binary returned is the binary
			 * generated by {@link Program.build}. The bits returned can be an
			 * implementation-specific intermediate representation (a.k.a. IR) or
			 * device specific executable bits or both. The decision on which
			 * information is returned in the binary is up to the OpenCL
			 * implementation.
			 *
			 *  TODO param_value points to an array of n pointers allocated by the caller, where n is the number of devices associated with program. The buffer sizes needed to allocate the memory that these n pointers refer to can be queried using the CL_PROGRAM_BINARY_SIZES query as described in this table.

Each entry in this array is used by the implementation as the location in memory where to copy the program binary for a specific device, if there is a binary available. To find out which device the program binary in the array refers to, use the CL_PROGRAM_DEVICES query to get the list of devices. There is a one-to-one correspondence between the array of n pointers returned by CL_PROGRAM_BINARIES and array of devices returned by CL_PROGRAM_DEVICES.

If an entry value in the array is NULL, the implementation skips copying the program binary for the specific device identified by the array index.

*

					 */
			BINARIES
		}
		/**
		 * Creates a kernel object.
		 *
		 * A kernel is a function declared in a program. A kernel is identified by
		 * the _\_kernel qualifier applied to any function in a program. A kernel
		 * object encapsulates the specific _\_kernel function declared in a program
		 * and the argument values to be used when executing this _\_kernel
		 * function.
		 *
		 * @param name A function name in the program declared with the _\_kernel qualifier
		 */
		[CCode(cname = "clCreateKernel")]
		public Kernel? create_kernel(string name, out Error errc);

		/**
		 * Creates kernel objects for all kernel functions in a program object.
		 *
		 * Creates kernel objects for all kernel functions in program. Kernel
		 * objects are not created for any _\_kernel functions in program that do
		 * not have the same function definition across all devices for which a
		 * program executable has been successfully built.
		 *
		 * Kernel objects can only be created once you have a program object with a
		 * valid program source or binary loaded into the program object and the
		 * program executable has been successfully built for one or more devices
		 * associated with program. No changes to the program executable are
		 * allowed while there are kernel objects associated with a program object.
		 * This means that calls to {@link Program.build} return
		 * {@link Error.INVALID_OPERATION} if there are kernel objects attached to a
		 * program object. The OpenCL context associated with program will be the
		 * context associated with kernel. The list of devices associated with
		 * program are the devices associated with kernel. Devices associated with
		 * a program object for which a valid program executable has been built can
		 * be used to execute kernels declared in the program object.
		 *
		 * @param kernels Where the kernel objects for kernels in program will be
		 * returned. If kernels is null, it is ignored. If kernels is not null, the
		 * array must be larger than or equal to the number of kernels in program.
		 *
		 * @param num_kernels The number of kernels in program. If num_kernels is
		 * null, it is ignored.
		 */
		[CCode(cname = "clCreateKernelsInProgram")]
		public Error create_kernels([CCode(array_length_pos = 0.1)] Kernel[]? kernels, out uint num_kernels);

		/**
		 * Builds (compiles and links) a program executable from the program source or binary.
		 *
		 * OpenCL allows program executables to be built using the source or the
		 * binary. This method must be called for program created using either
		 * {@link Context.create_program_with_source} or {@link Context.create_program_with_binary}
		 * to build the program executable for one or more devices associated with
		 * program.
		 *
		 * @param devices A list of devices associated with program. If null, the
		 * program executable is built for all devices associated with program for
		 * which a source or binary has been loaded. Otherwise, the program
		 * executable is built for devices specified in this list for which a source
		 * or binary has been loaded.
		 *
		 * @param options A string that describes the build options to be used for
		 * building the program executable. Consult the OpenCL reference for build
		 * options.
		 *
		 * @param notify The notification routine is a callback function that an
		 * application can register and which will be called when the program
		 * executable has been built (successfully or unsuccessfully). If not null,
		 * this method does not need to wait for the build to complete and can return
		 * immediately. Otherwise, it does not return until the build has completed.
		 * This callback function may be called asynchronously by the OpenCL
		 * implementation. It is the application's responsibility to ensure that the
		 * callback function is thread-safe.
		 */
		[CCode(cname = "clBuildProgram")]
		public Error build([CCode(array_length_pos = 0.1)] Device[]? devices, string options, Notify? notify);
		/**
		 * Get specific information about the OpenCL platform.
		 * @param buffer where the information will be stored
		 * @param size the size of the information stored, in bytes
		 */
		[CCode(cname = "clGetProgramInfo")]
		public Error get_info(Info info, [CCode(array_length_pos = 1.1)] uint8[]? buffer, out size_t size);
		/**
		 * Call {@link get_info} with automatic space allocation.
		 */
		public Error get_info_auto(Info info, out uint8[]? buffer) {
			buffer = null;
			size_t size;
			Error err;
			if ((err = get_info(info, null, out size)) != Error.SUCCESS) {
				return err;
			}
			buffer = new uint8[size];
			return get_info(info, buffer, null);
		}
		/**
		 * Get specific information about the build.
		 * @param buffer where the information will be stored
		 * @param size the size of the information stored, in bytes
		 */
		[CCode(cname = "clGetProgramBuildInfo")]
		public Error get_build_info(Device device, BuildInfo info, [CCode(array_length_pos = 1.1)] uint8[]? buffer, out size_t size);
		/**
		 * Call {@link get_build_info} with automatic space allocation.
		 */
		public Error get_build_info_auto(Device device, BuildInfo info, out uint8[]? buffer) {
			buffer = null;
			size_t size;
			Error err;
			if ((err = get_build_info(device, info, null, out size)) != Error.SUCCESS) {
				return err;
			}
			buffer = new uint8[size];
			return get_build_info(device, info, buffer, null);
		}
}

	[CCode(cname = "struct _cl_sampler", ref_function = "clRetainSampler", unref_function = "clReleaseSampler", ref_function_void = true, has_type_id = false)]
	public class Sampler {
		[CCode(cname = "cl_addressing_mode", cprefix = "CL_ADDRESS_", has_type_id = false)]
		public enum AddressingMode {
			NONE,
			CLAMP_TO_EDGE,
			CLAMP,
			REPEAT
		}
		[CCode(cname = "cl_filter_mode", cprefix = "CL_FILTER_", has_type_id = false)]
		public enum FilterMode {
			NEAREST,
			LINE
		}
		[CCode(cname = "cl_sampler_info", cprefix = "CL_SAMPLER_", has_type_id = false)]
		public enum Info {
			/**
			 * The sampler reference count. (uint)
			 *
			 * The reference count returned should be considered immediately stale.
			 * It is unsuitable for general use in applications. This feature is
			 * provided for identifying memory leaks.
			 */
			REFERENCE_COUNT,
			/**
			 * The context specified when the sampler is created. ({@link Context})
			 */
			CONTEXT,
			/**
			 * The addressing mode value associated with sampler. ({@link AddressingMode})
			 */
			ADDRESSING_MODE,
			/**
			 * The filter mode value associated with sampler. ({@link FilterMode})
			 */
			FILTER_MODE,
			/**
			 * The normalized coords value associated with sampler. (bool)
			 */
			NORMALIZED_COORDS
		}
		[CCode(cname = "clGetSamplerInfo")]
		public Error get_info(Info info, [CCode(array_length_pos = 1.1)] uint8[]? buffer, out size_t size);
		/**
		 * Call {@link get_info} with automatic space allocation.
		 */
		public Error get_info_auto(Info info, out uint8[]? buffer) {
			buffer = null;
			size_t size;
			Error err;
			if ((err = get_info(info, null, out size)) != Error.SUCCESS) {
				return err;
			}
			buffer = new uint8[size];
			return get_info(info, buffer, null);
		}
}

	[CCode(cname = "buffer_create_info", has_type_id = false)]
	public struct buffer_create_info {
	}

	[CCode(cname = "cl_buffer_region", has_type_id = false)]
	public struct buffer_region : buffer_create_info {
		public size_t origin;
		public size_t size;
	}

	[CCode(cname = "cl_image_format", has_type_id = false)]
	public struct image_format {
		[CCode(cname = "image_channel_order")]
    public ChannelOrder order;
		[CCode(cname = "image_channel_data_type")]
		public ChannelType type;
	}
	[CCode(cname = "cl_channel_order", cprefix = "CL_", has_type_id = false)]
	public enum ChannelOrder {
		R,
		A,
		RG,
		RA,
		RGB,
		RGBA,
		BGRA,
		ARGB,
		INTENSITY,
		LUMINANCE,
		Rx,
		RGx,
		RGBx
	}

	[CCode(cname = "cl_channel_type", cprefix = "CL_", has_type_id = false)]
	public enum ChannelType {
		SNORM_INT8,
		SNORM_INT16,
		UNORM_INT8,
		UNORM_INT16,
		UNORM_SHORT_565,
		UNORM_SHORT_555,
		UNORM_INT_101010,
		SIGNED_INT8,
		SIGNED_INT16,
		SIGNED_INT32,
		UNSIGNED_INT8,
		UNSIGNED_INT16,
		UNSIGNED_INT32,
		HALF_FLOAT,
		FLOAT
	}

	[CCode(cname = "cl_command_type", cprefix = "CL_COMMAND_", has_type_id = false)]
	public enum CommandType {
		NDRANGE_KERNEL,
		TASK,
		NATIVE_KERNEL,
		READ_BUFFER,
		WRITE_BUFFER,
		COPY_BUFFER,
		READ_IMAGE,
		WRITE_IMAGE,
		COPY_IMAGE,
		COPY_BUFFER_TO_IMAGE,
		COPY_IMAGE_TO_BUFFER,
		MAP_BUFFER,
		MAP_IMAGE,
		UNMAP_MEM_OBJECT,
		MARKER,
		ACQUIRE_GL_OBJECTS,
		RELEASE_GL_OBJECTS,
		READ_BUFFER_RECT,
		WRITE_BUFFER_RECT,
		COPY_BUFFER_RECT,
		USER
	}

	/**
	 * Error Codes
	 */
	[CCode(cname = "int", cprefix = "CL_", has_type_id = false)]
	public enum Error {
		SUCCESS,
		DEVICE_NOT_FOUND,
		DEVICE_NOT_AVAILABLE,
		COMPILER_NOT_AVAILABLE,
		MEM_OBJECT_ALLOCATION_FAILURE,
		OUT_OF_RESOURCES,
		OUT_OF_HOST_MEMORY,
		PROFILING_INFO_NOT_AVAILABLE,
		MEM_COPY_OVERLAP,
		IMAGE_FORMAT_MISMATCH,
		IMAGE_FORMAT_NOT_SUPPORTED,
		BUILD_PROGRAM_FAILURE,
		MAP_FAILURE,
		MISALIGNED_SUB_BUFFER_OFFSET,
		EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST,

		INVALID_VALUE,
		INVALID_DEVICE_TYPE,
		INVALID_PLATFORM,
		INVALID_DEVICE,
		INVALID_CONTEXT,
		INVALID_QUEUE_PROPERTIES,
		INVALID_COMMAND_QUEUE,
		INVALID_HOST_PTR,
		INVALID_MEM_OBJECT,
		INVALID_IMAGE_FORMAT_DESCRIPTOR,
		INVALID_IMAGE_SIZE,
		INVALID_SAMPLER,
		INVALID_BINARY,
		INVALID_BUILD_OPTIONS,
		INVALID_PROGRAM,
		INVALID_PROGRAM_EXECUTABLE,
		INVALID_KERNEL_NAME,
		INVALID_KERNEL_DEFINITION,
		INVALID_KERNEL,
		INVALID_ARG_INDEX,
		INVALID_ARG_VALUE,
		INVALID_ARG_SIZE,
		INVALID_KERNEL_ARGS,
		INVALID_WORK_DIMENSION,
		INVALID_WORK_GROUP_SIZE,
		INVALID_WORK_ITEM_SIZE,
		INVALID_GLOBAL_OFFSET,
		INVALID_EVENT_WAIT_LIST,
		INVALID_EVENT,
		INVALID_OPERATION,
		INVALID_GL_OBJECT,
		INVALID_BUFFER_SIZE,
		INVALID_MIP_LEVEL,
		INVALID_GLOBAL_WORK_SIZE,
		INVALID_PROPERTY
	}

	/**
	 * Allows the implementation to release the resources allocated by the OpenCL compiler.
	 *
	 * This is a hint from the application and does not guarantee that the
	 * compiler will not be used in the future or that the compiler will actually
	 * be unloaded by the implementation. Calls to {@link Program.build} after
	 * this method will reload the compiler, if necessary, to build the
	 * appropriate program executable.
	 */
	[CCode(cname = "clUnloadCompiler")]
	public Error unload_compiler();

	/**
	 * Waits on the host thread for commands identified by event objects to complete.
	 */
	[CCode(cname = "clWaitForEvents")]
	public Error wait_for_events([CCode(array_length_pos = 0.1)] Event[] events);

	[CCode(cname = "clGetExtensionFunctionAddress", simple_generics = true)]
	public T? get_extension<T>(string name);
}

