/*
 * API for LLVM 3.0
 *
 * Maintained by Andre Masella <https://github.com/apmasell/vapis>
 * Based on Marc-André Lureau <http://gitorious.org/llvm-vapi>
 *
 * Marc-André Lureau did not list a license, but I assume this, since it based
 * on the LLVM code, it is distributed under the University of Illinois Open
 * Source Licence.
 */
[CCode (cheader_filename = "llvm-c/Core.h")]
namespace LLVM {
	/**
	 * IR Builder
	 */
	[Compact]
	[CCode (cname="struct LLVMOpaqueBuilder", free_function="LLVMDisposeBuilder", has_type_id = false)]
	public class Builder {
		/**
		 * Create a new builder in the global context.
		 */
		[CCode (cname = "LLVMCreateBuilder")]
		public Builder ();

		[CCode (cname = "LLVMPositionBuilder")]
		public void position (BasicBlock block, Instruction instr);
		[CCode (cname = "LLVMPositionBuilderBefore")]
		public void position_before (Instruction instr);
		[CCode (cname = "LLVMPositionBuilderAtEnd")]
		public void position_at_end (BasicBlock block);

		[CCode (cname = "LLVMBuildRetVoid")]
		public ReturnInst build_ret_void ();
		[CCode (cname = "LLVMBuildRet")]
		public ReturnInst build_ret (LLVM.Value v);
		[CCode (cname = "LLVMBuildAggregateRet")]
		public ReturnInst build_aggregate_ret (LLVM.Value[] ret_vals);

		[CCode (cname = "LLVMBuildBr")]
		public BranchInst build_br (BasicBlock dest);
		[CCode (cname = "LLVMBuildCondBr")]
		public BranchInst build_cond_br (Value @if, BasicBlock then, BasicBlock @else);

		[CCode (cname = "LLVMBuildSwitch")]
		public SwitchInst build_switch (Value v, BasicBlock @else, uint num_cases = 10);

		[CCode (cname = "LLVMBuildInvoke")]
		public InvokeInst build_invoke (Value Fn, [CCode (array_length_pos = 2.9)] Value[] args, BasicBlock then, BasicBlock @catch, string name = "");

		[CCode(cname = "LLVMBuildLandingPad")]
		public Value build_landing_pad(Ty ty, Value pers_fn, uint num_clauses, string name);
		[CCode(cname = "LLVMBuildResume")]
		public Value build_resume(Value exn);

		[CCode (cname = "LLVMBuildUnreachable")]
		public UnreachableInst build_unreachable ();

		[CCode (cname = "LLVMBuildAdd")]
		public Value build_add (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildNSWAdd")]
		public Value build_nswadd (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildFAdd")]
		public Value build_fadd (Value lhs, Value rhs, string name = "");

		[CCode (cname = "LLVMBuildSub")]
		public Value build_sub (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildFSub")]
		public Value build_fsub (Value lhs, Value rhs, string name = "");

		[CCode (cname = "LLVMBuildMul")]
		public Value build_mul (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildFMul")]
		public Value build_fmul (Value lhs, Value rhs, string name = "");

		[CCode (cname = "LLVMBuildUDiv")]
		public Value build_udiv (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildFDiv")]
		public Value build_fdiv (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildSDiv")]
		public Value build_sdiv (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildExactSDiv")]
		public Value build_exact_sdiv (Value lhs, Value rhs, string name = "");

		[CCode (cname = "LLVMBuildURem")]
		public Value build_urem (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildSRem")]
		public Value build_srem (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildFRem")]
		public Value build_frem (Value lhs, Value rhs, string name = "");

		[CCode (cname = "LLVMBuildShl")]
		public Value build_shl (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildLShr")]
		public Value build_lshr (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildAShr")]
		public Value build_ashr (Value lhs, Value rhs, string name = "");

		[CCode (cname = "LLVMBuildAnd")]
		public Value build_and (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildOr")]
		public Value build_or (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildXor")]
		public Value build_xor (Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildNeg")]
		public Value build_neg (Value v, string name = "");
		[CCode (cname = "LLVMBuildFNeg")]
		public Value build_fneg (Value v, string name = "");
		[CCode (cname = "LLVMBuildNot")]
		public Value build_not (Value v, string name = "");

		[CCode (cname = "LLVMBuildMalloc")]
		public CallInst build_malloc (Ty ty, string name = "");
		[CCode (cname = "LLVMBuildArrayMalloc")]
		public CallInst build_array_malloc (Ty ty, Value val, string name = "");
		[CCode (cname = "LLVMBuildAlloca")]
		public AllocaInst build_alloca (Ty ty, string name = "");
		[CCode (cname = "LLVMBuildArrayAlloca")]
		public AllocaInst build_array_alloca (Ty ty, Value val, string name = "");
		[CCode (cname = "LLVMBuildFree")]
		public CallInst build_free (Value pointer_val);

		[CCode (cname = "LLVMBuildLoad")]
		public LoadInst build_load (Value pointer_val, string name = "");
		[CCode (cname = "LLVMBuildStore")]
		public StoreInst build_store (Value val, Value ptr);

		[CCode (cname = "LLVMBuildGEP")]
		public GEPInst build_gep (Value pointer, [CCode (array_length_pos = 2.9)] Value[] indices, string name = "");
		[CCode (cname = "LLVMBuildInBoundsGEP")]
		public GEPInst build_in_bounds_gep (Value pointer, [CCode (array_length_pos = 2.9)] Value[] indices, string name = "");
		[CCode (cname = "LLVMBuildStructGEP")]
		public GEPInst build_struct_gep (Value pointer, uint idx, string name = "");
		[CCode (cname = "LLVMBuildGlobalString")]
		public GlobalValue build_global_string (string str, string name = "");
		[CCode (cname = "LLVMBuildGlobalStringPtr")]
		public GEPInst build_global_string_ptr (string str, string name = "");

		[CCode (cname = "LLVMBuildTrunc")]
		public CastInst build_trunc (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildZExt")]
		public CastInst build_zext (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildSExt")]
		public CastInst build_sext (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildFPToSI")]
		public CastInst build_fp_to_si (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildFPToUI")]
		public CastInst build_fp_to_ui (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildUIToFP")]
		public CastInst build_ui_to_fp (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildSIToFP")]
		public CastInst build_si_to_fp (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildFPTrunc")]
		public CastInst build_fp_trunc (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildFPExt")]
		public CastInst build_fp_ext (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildPtrToInt")]
		public CastInst build_ptr_to_int (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildIntToPtr")]
		public CastInst build_int_to_ptr (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildBitCast")]
		public CastInst build_bit_cast (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildZExtOrBitCast")]
		public CastInst build_zext_or_bit_cast (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildSExtOrBitCast")]
		public CastInst build_sext_or_bit_cast (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildTruncOrBitCast")]
		public CastInst build_trunc_or_bit_cast (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildPointerCast")]
		public CastInst build_pointer_cast (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildIntCast")]
		public CastInst build_int_cast (Value val, Ty destty, string name = "");
		[CCode (cname = "LLVMBuildFPCast")]
		public CastInst build_fp_cast (Value val, Ty destty, string name = "");

		[CCode (cname = "LLVMBuildICmp")]
		public ICmpInst build_icmp (IntPredicate op, Value lhs, Value rhs, string name = "");
		[CCode (cname = "LLVMBuildFCmp")]
		public FCmpInst build_fcmp (RealPredicate op, Value lhs, Value rhs, string name = "");

		[CCode (cname = "LLVMBuildPhi")]
		public PHINode build_phi (Ty ty, string name = "");
		[CCode (cname = "LLVMBuildCall")]
		public CallInst build_call (Function fn, [CCode (array_length_pos = 2.9)] LLVM.Value[] args, string name = "");
		[CCode (cname = "LLVMBuildSelect")]
		public SelectInst build_select (Value @if, Value then, Value @else, string name = "");
		[CCode (cname = "LLVMBuildVAArg")]
		public VAArgInst build_vaarg (Value list, Ty ty, string name = "");
		[CCode (cname = "LLVMBuildExtractElement")]
		public ExtractElementInst build_extract_element (Value vec_val, Value index, string name = "");
		[CCode (cname = "LLVMBuildInsertElement")]
		public InsertElementInst build_insert_element (Value vec_val, Value elt_val, Value index, string name = "");
		[CCode (cname = "LLVMBuildShuffleVector")]
		public ShuffleVectorInst build_shuffle_vector (Value v1, Value v2, Value mask, string name = "");
		[CCode (cname = "LLVMBuildExtractValue")]
		public ExtractValueInst build_extract_value (Value agg_val, uint index, string name = "");
		[CCode (cname = "LLVMBuildInsertValue")]
		public InsertValueInst build_insert_value (Value agg_val, Value elt_val, uint index, string name = "");

		[CCode (cname = "LLVMBuildIsNotNull")]
		public ICmpInst build_is_not_null (Value val, string name = "");
		[CCode (cname = "LLVMBuildIsNull")]
		public ICmpInst build_is_null (Value val, string name = "");
		[CCode (cname = "LLVMBuildPtrDiff")]
		public Value build_ptr_diff (Value lhs, Value rhs, string name = "");

		[CCode (cname = "LLVMGetInsertBlock")]
		public BasicBlock get_insert_block ();
		[CCode (cname = "LLVMClearInsertionPosition")]
		public void clear_insertion_position ();
		[CCode (cname = "LLVMInsertIntoBuilder")]
		public void insert (Instruction instr);
		[CCode (cname = "LLVMInsertIntoBuilderWithName")]
		public void insert_with_name (Instruction instr, string name = "");

		public BasicBlock insert_block { [CCode (cname = "LLVMGetInsertBlock")] get; }
	}

	/**
	 * Owner of LLVM's infrastructure
	 *
	 * This is an important class for using LLVM in a threaded context. It
	 * (opaquely) owns and manages the core "global" data of LLVM's core
	 * infrastructure, including the type and constant uniquing tables. It
	 * provides no locking guarantees, so you should be careful to have one
	 * context per thread.
	 */
	[Compact]
	[CCode (cname="struct LLVMOpaqueContext", free_function="LLVMContextDispose", has_type_id = false)]
	public class Context {
		[CCode (cname = "LLVMContextCreate")]
		public Context();

		[CCode (cname = "LLVMAppendBasicBlockInContext")]
		BasicBlock append_basic_block (Value fn, string name = "");
		[CCode (cname = "LLVMInsertBasicBlockInContext")]
		BasicBlock insert_basic_block (BasicBlock bb, string name = "");

		[CCode (cname = "LLVMGetGlobalContext")]
		public static unowned Context get_global ();

		[CCode (cname = "LLVMModuleCreateWithNameInContext", instance_pos = -1)]
		public Module create_module (string name);
		/**
		 * Create a new builder in the supplied context.
		 *
		 * The builder will become invalid if the context is released.
		 */
		[CCode (cname = "LLVMCreateBuilderInContext")]
		public Builder create_builder ();

		[CCode (cname = "LLVMDoubleTypeInContext")]
		public Ty double ();
		[CCode (cname = "LLVMFP128TypeInContext")]
		public Ty fp128 ();
		[CCode (cname = "LLVMFloatTypeInContext")]
		public Ty float ();
		[CCode (cname = "LLVMInt16TypeInContext")]
		public Ty int16 ();
		[CCode (cname = "LLVMInt1TypeInContext")]
		public Ty int1 ();
		[CCode (cname = "LLVMInt32TypeInContext")]
		public Ty int32 ();
		[CCode (cname = "LLVMInt64TypeInContext")]
		public Ty int64 ();
		[CCode (cname = "LLVMInt8TypeInContext")]
		public Ty int8 ();
		[CCode (cname = "LLVMIntTypeInContext")]
		public Ty int (uint num_bits);
		[CCode (cname = "LLVMLabelTypeInContext")]
		public Ty label ();
		[CCode (cname = "LLVMPPCFP128TypeInContext")]
		public Ty ppcfp128 ();
		[CCode (cname = "LLVMStructTypeInContext")]
		public Ty struct (Ty[] element_types, bool packed);
		[CCode (cname = "LLVMVoidTypeInContext")]
		public Ty void ();
		[CCode (cname = "LLVMX86FP80TypeInContext")]
		public Ty x86fp80 ();
		[CCode (cname = "LLVMConstStringInContext")]
		public Constant const_string (uint8[] str, bool dont_null_terminate);
		[CCode (cname = "LLVMConstStructInContext")]
		public Constant const_struct (LLVM.Value[] constant_vals, bool packed);

	}

	/**
	 * Interface for implementation execution of LLVM modules
	 *
	 * This interface is designed to support both interpreter and just-in-time
	 * (JIT) compiler implementations.
	 */
	[Compact]
	[CCode (cname="struct LLVMOpaqueExecutionEngine", free_function="LLVMDisposeExecutionEngine", cheader_filename = "llvm-c/ExecutionEngine.h", has_type_id = false)]
	public class ExecutionEngine {
		/**
		 * Create an execution engine which is appropriate for the current machine.
		 */
		[CCode (cname = "LLVMCreateExecutionEngine")]
		public static bool create_execution_engine (out ExecutionEngine ee, owned ModuleProvider m, out string error);
		/**
		 * This is the factory method for creating a JIT for the current machine,
		 * it does not fall back to the interpreter.
		 *
		 * Clients should make sure to initialize targets prior to calling this function.
		*/
		[CCode (cname = "LLVMCreateJITCompiler")]
		public static bool create_jit_compiler (out ExecutionEngine jit, owned ModuleProvider m, uint opt_level, out string error);
		[CCode (cname = "LLVMCreateInterpreter")]
		public static bool create_interpreter (out ExecutionEngine interp, owned ModuleProvider m, out string error);

		public TargetData target_data { [CCode (cname = "LLVMGetExecutionEngineTargetData")] get; }

		/**
		 * Tell the execution engine that the specified global is at the specified location.
		 *
		 * This is used internally as functions are JIT'd and as global variables
		 * are laid out in memory. It can and should also be used by clients of the
		 * EE that want to have an LLVM global overlay existing data in memory.
		 * Mappings are automatically removed when their {@link GlobalValue} is destroyed.
		 */
		[CCode (cname = "LLVMAddGlobalMapping")]
		public void add_global_mapping (Value global, void* addr);
		/**
		 * Add a module to the list of modules that we can JIT from.
		 */
		[CCode (cname = "LLVMAddModuleProvider")]
		public void add_module_provider (owned ModuleProvider mp);
		[CCode (cname = "LLVMRemoveModuleProvider")]
		public int remove_module_provider (ModuleProvider mp, out Module mod, out string error);

		/**
		 * Execute the specified function with the specified arguments, and return the result.
		 */
		[CCode (cname = "LLVMRunFunction")]
		public GenericValue run_function (Function f, [CCode (array_length_pos = 1.9)] GenericValue[] args);
		/**
		 * This method is used to execute all of the static constructors for a program.
		 */
		[CCode (cname = "LLVMRunStaticConstructors")]
		public void run_static_constructors ();
		/**
		 * This method is used to execute all of the static destructors for a program.
		 */
		[CCode (cname = "LLVMRunStaticDestructors")]
		public void run_static_destructors ();
		[CCode (cname = "LLVMRunFunctionAsMain")]
		public int run_function_as_main (Function f, [CCode (array_length_pos = 1.9)] string[] args, [CCode (array_length = false, array_null_terminated = true)] string[] env);
		/**
		 * Release memory in the ExecutionEngine corresponding to the machine code emitted to execute this function.
		 *
		 * Useful for garbage-collecting generated code.
		 */
		[CCode (cname = "LLVMFreeMachineCodeForFunction")]
		public void free_machine_code_for_function (Function f);
		/**
		 * Search all of the active modules to find the one that defines the function.
		 *
		 * This is very slow operation and shouldn't be used for general code.
		 */
		[CCode (cname = "LLVMFindFunction")]
		public int find_function (string name, out Function f);
		/**
		 * This returns the address of the specified global value.
		 *
		 * This may involve code generation if it's a function.
		 */
		[CCode (cname = "LLVMGetPointerToGlobal")]
		public void* get_pointer_to_global (GlobalValue global);
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueGenericValue", free_function="LLVMDisposeGenericValue", cheader_filename = "llvm-c/ExecutionEngine.h", has_type_id = false)]
	public class GenericValue {
		[CCode (cname = "LLVMCreateGenericValueOfFloat", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public GenericValue.of_float (Ty ty, double n);
		[CCode (cname = "LLVMCreateGenericValueOfInt", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public GenericValue.of_int (Ty ty, uint n, int is_signed);
		[CCode (cname = "LLVMCreateGenericValueOfPointer", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public GenericValue.of_pointer (void* p);

		public uint int_witdh { [CCode (cname = "LLVMGenericValueIntWidth", cheader_filename = "llvm-c/ExecutionEngine.h")] get; }

		[CCode (cname = "LLVMGenericValueToFloat", instance_pos = 1.9, cheader_filename = "llvm-c/ExecutionEngine.h")]
		public double to_float (Ty ty);
		[CCode (cname = "LLVMGenericValueToInt", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public uint to_int (int is_signed);
		[CCode (cname = "LLVMGenericValueToPointer", cheader_filename = "llvm-c/ExecutionEngine.h")]
		public void* to_pointer ();
	}

	[Compact]
	[CCode (cname="struct LLVMOpaqueMemoryBuffer", free_function="LLVMDisposeMemoryBuffer", cheader_filename = "llvm-c/BitReader.h", has_type_id = false)]
	public class MemoryBuffer {
		[CCode (cname = "LLVMCreateMemoryBufferWithSTDIN")]
		public static int create_with_stdin (out MemoryBuffer membuf, out string message);
		[CCode (cname = "LLVMCreateMemoryBufferWithContentsOfFile")]
		public static int create_with_contents_of_file (string path, out MemoryBuffer membuf, out string message);

		// TODO ownedness of self depends on result
		[CCode (cname = "LLVMGetBitcodeModuleProvider")]
		public bool get_module_provider (out unowned ModuleProvider mp, out string message);
		[CCode (cname = "LLVMGetBitcodeModuleProviderInContext", instance_pos = 1.9)]
		public bool get_module_provider_in_context (Context context, out unowned ModuleProvider mp, out string message);
		[CCode (cname = "LLVMParseBitcode", cheader_filename = "llvm-c/BitReader.h")]
		public bool parse_bitcode (out unowned Module module, out string message);
		[CCode (cname = "LLVMParseBitcodeInContext", instance_pos = 1.9, cheader_filename = "llvm-c/BitReader.h")]
		public bool parse_bitcode_in_context (Context Context, out unowned Module module, out string message);
	}

	/**
	 * A wrapper around modules.
	 *
	 * This exists for historical reasons.
	 */
	[Compact]
	[CCode (cname="struct LLVMOpaqueModuleProvider", free_function="LLVMDisposeModuleProvider", has_type_id = false)]
	public class ModuleProvider {
		[CCode (cname = "LLVMCreateModuleProviderForExistingModule")]
		public ModuleProvider (owned Module m);
	}

	/**
	 * Container for the LLVM Intermediate Representation
	 *
	 * An instance is used to store all the information related to an LLVM
	 * module. Modules are the top level container of all other LLVM Intermediate
	 * Representation (IR) objects. Each module directly contains a list of
	 * globals variables, a list of functions, a list of libraries (or other
	 * modules) this module depends on, a symbol table, and various data about
	 * the target's characteristics.
	 *
	 * A module maintains a list of all constant references to global variables
	 * in the module. When a global variable is destroyed, it should have no
	 * entries in this table.
	 */
	[Compact]
	[CCode (cname="struct LLVMOpaqueModule", free_function="LLVMDisposeModule", has_type_id = false)]
	public class Module {
		[CCode (cname = "LLVMModuleCreateWithName")]
		public Module (string name);

		/**
		 * The type sizes and alignments expected by this module.
		 */
		public string data_layout {
			[CCode (cname = "LLVMGetDataLayout")]
			get;
			[CCode (cname = "LLVMSetDataLayout")]
			set;
		}

		public string target {
			[CCode (cname = "LLVMGetTarget")]
			get;
			[CCode (cname = "LLVMSetTarget")]
			set;
		}

		[CCode (cname = "LLVMAddAlias")]
		public GlobalAlias add_alias (LLVM.Ty ty, LLVM.Value aliasee, string name);

		[CCode (cname = "LLVMDumpModule")]
		public void dump ();

		[CCode (cname = "LLVMGetNamedGlobal")]
		public GlobalVariable get_named_global (string name);
		public GlobalVariable first_global { [CCode (cname = "LLVMGetFirstGlobal")] get; }
		public GlobalVariable last_global { [CCode (cname = "LLVMGetLastGlobal")] get; }

		/**
		 * Look up the specified function in the module symbol table.
		 */
		[CCode (cname = "LLVMGetNamedFunction")]
		public Function? get_named_function (string name);
		public Function first_function { [CCode (cname = "LLVMGetFirstFunction")] get; }
		public Function last_function { [CCode (cname = "LLVMGetLastFunction")] get; }

		[CCode (cname = "LLVMVerifyModule", cheader_filename = "llvm-c/Analysis.h")]
		public int verify (VerifierFailureAction action, out string message);
		[CCode (cname = "LLVMWriteBitcodeToFile", cheader_filename = "llvm-c/BitWriter.h")]
		public int write_bitcode_to_file (string path);
		[CCode (cname = "LLVMWriteBitcodeToFD", cheader_filename = "llvm-c/BitWriter.h")]
		public bool write_bitcode_to_fd(int fd, bool should_close = true, bool unbuffered = false);
		[Deprecated(replacement = "write_bitcode_to_fd")]
		[CCode (cname = "LLVMWriteBitcodeToFileHandle", cheader_filename = "llvm-c/BitWriter.h")]
		public bool write_bitcode_to_file_handle (int handle);
		public bool write_bitcode_to_file_stream(
#if POSIX
Posix.FILE
#else
GLib.FileStream
#endif
		file) {
			write_bitcode_to_fd(file.fileno(), false, false);
		}

		[CCode (cname = "LLVMAddFunction")]
		public Function add_function(string name, LLVM.Ty function_ty);
		[CCode (cname = "LLVMAddGlobal")]
		public GlobalVariable add_global(LLVM.Ty ty, string name);
		[CCode (cname = "LLVMAddAlias")]
		public GlobalAlias add_global_alias(LLVM.Ty ty, LLVM.Value aliasee, string name);
	}

	/**
	 * An abstract interface to allow code to add passes to a pass manager without having to hard-code what kind of pass manager it is.
	 */
	[Compact]
	[CCode (cname="struct LLVMOpaquePassManager", free_function="LLVMDisposePassManager", has_type_id = false)]
	public class PassManagerBase {
		[CCode (cname = "LLVMAddTargetData", instance_pos = -1)]
		public void add_target_data (TargetData target);
		[CCode (cname = "LLVMAddAggressiveDCEPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_aggressive_dce ();
		[CCode (cname = "LLVMAddArgumentPromotionPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_argument_promotion ();
		[CCode (cname = "LLVMAddCFGSimplificationPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_cfg_simplification ();
		[CCode (cname = "LLVMAddConstantMergePass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_constant_merge ();
		[CCode (cname = "LLVMAddConstantPropagationPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_constant_propagation ();
		[CCode (cname = "LLVMAddDeadArgEliminationPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_dead_arg_elimination ();
		[CCode (cname = "LLVMAddDeadStoreEliminationPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_dead_store_elimination ();
		[CCode (cname = "LLVMAddDemoteMemoryToRegisterPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_demote_memory_to_register ();
		[CCode (cname = "LLVMAddFunctionAttrsPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_function_attrs ();
		[CCode (cname = "LLVMAddFunctionInliningPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_function_inlining ();
		[CCode(cname = "LLVMAddAlwaysInlinerPass")]
		public void add_always_inliner();
		[CCode (cname = "LLVMAddGVNPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_gvn ();
		[CCode (cname = "LLVMAddGlobalDCEPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_global_dce ();
		[CCode (cname = "LLVMAddGlobalOptimizerPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_global_optimizer_pass ();
		[CCode (cname = "LLVMAddIPConstantPropagationPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_ipconstant_propagation ();
		[CCode (cname = "LLVMAddIndVarSimplifyPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_ind_var_simplify ();
		[CCode (cname = "LLVMAddInstructionCombiningPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_instruction_combining ();
		[CCode (cname = "LLVMAddJumpThreadingPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_jump_threading ();
		[CCode (cname = "LLVMAddLICMPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_licm ();
		[CCode (cname = "LLVMAddLoopDeletionPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_loop_deletion ();
		[CCode (cname = "LLVMAddLoopIndexSplitPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_loop_index_split ();
		[CCode (cname = "LLVMAddLoopRotatePass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_loop_rotate ();
		[CCode (cname = "LLVMAddLoopUnrollPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_loop_unroll ();
		[CCode (cname = "LLVMAddLoopUnswitchPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_loop_unswitch ();
		[CCode (cname = "LLVMAddMemCpyOptPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_memcpy_opt ();
		[CCode (cname = "LLVMAddPromoteMemoryToRegisterPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_promote_memory_to_register ();
		[CCode(cname = "LLVMAddLoopIdiomPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_loop_idiom();
		[CCode (cname = "LLVMAddPruneEHPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_prune_eh ();
		[CCode (cname = "LLVMAddReassociatePass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_reassociate ();
		[CCode (cname = "LLVMAddSCCPPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_sccp ();
		[CCode (cname = "LLVMAddScalarReplAggregatesPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_scalar_repl_aggregates ();
		[CCode (cname = "LLVMAddScalarReplAggregatesPassSSA", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_scalar_repl_aggregates_ssa();
		[CCode (cname = "LLVMAddSimplifyLibCallsPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_simplify_lib_calls ();
		[CCode (cname = "LLVMAddStripDeadPrototypesPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_strip_dead_prototypes ();
		[CCode (cname = "LLVMAddStripSymbolsPass", cheader_filename = "llvm-c/Transforms/IPO.h")]
		public void add_strip_symbols ();
		[CCode (cname = "LLVMAddTailCallEliminationPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_tailcall_elimination ();
		[CCode (cname = "LLVMAddCorrelatedValuePropagationPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_correlated_value_propagation();
		[CCode (cname = "LLVMAddEarlyCSEPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_early_cse();
		[CCode (cname = "LLVMAddLowerExpectIntrinsicPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_lower_expect_intrinsic();
		[CCode (cname = "LLVMAddTypeBasedAliasAnalysisPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_type_based_alias_analysis();
		[CCode (cname = "LLVMAddBasicAliasAnalysisPass", cheader_filename = "llvm-c/Transforms/Scalar.h")]
		public void add_basic_alias_analysis();
	}

	/**
	 * Manages module PassManagers.
	 */
	[Compact]
	[CCode (cname="struct LLVMOpaquePassManager", free_function="LLVMDisposePassManager", has_type_id = false)]
	public class PassManager: PassManagerBase {
		[CCode (cname = "LLVMCreatePassManager")]
		public PassManager ();
		/**
		 * Execute all of the passes scheduled for execution.
		 *
		 * @return true if any of the passes modifies the module.
		 */
		[CCode (cname = "LLVMRunPassManager")]
		public bool run (Module m);
	}

	/**
	 * Manages function and basic block pass managers.
	 */
	[Compact]
	[CCode (cname="struct LLVMOpaquePassManager", free_function="LLVMDisposePassManager", has_type_id = false)]
	public class FunctionPassManager: PassManagerBase {
		[CCode (cname = "LLVMCreateFunctionPassManager")]
		public FunctionPassManager (ModuleProvider mp);

		/**
		 * Run all of the finalizers for the function passes.
		 */
		[CCode (cname = "LLVMFinalizeFunctionPassManager")]
		public bool finalize ();
		/**
		 * Run all of the initializers for the function passes.
		 */
		[CCode (cname = "LLVMInitializeFunctionPassManager")]
		public bool initialize ();
		/**
		 * Execute all of the passes scheduled for execution.
		 * @return true if any of the passes modifies the function.
		 */
		[CCode (cname = "LLVMRunFunctionPassManager")]
		public int run (Function f);
	}

	[CCode (cname = "LLVMByteOrdering", cprefix = "", has_type_id = "0", cheader_filename = "llvm-c/Target.h")]
	public enum ByteOrdering {
		[CCode (cname = "LLVMBigEndian")]
		BIG_ENDIAN,
		[CCode (cname = "LLVMLittleEndian")]
		LITTLE_ENDIAN
	}

	[Compact]
	[CCode (cheader_filename = "llvm-c/Target.h", cname="struct LLVMOpaqueTargetData", free_function="LLVMDisposeTargetData", has_type_id = false)]
	public class TargetData {
		/**
		 * Constructs a TargetData from a specification string.
		 */
		[CCode (cname = "LLVMCreateTargetData", cheader_filename = "llvm-c/Target.h")]
		public TargetData (string string_rep);

		[CCode (cname = "LLVMOffsetOfElement", cheader_filename = "llvm-c/Target.h")]
		public uint offset_of_element (Ty struct_ty, uint element);
		public uint pointer_size { [CCode (cname = "LLVMPointerSize", cheader_filename = "llvm-c/Target.h")] get; }
		public string string_rep { [CCode (cname = "LLVMCopyStringRepOfTargetData", cheader_filename = "llvm-c/Target.h")] owned get; }
		public ByteOrdering byte_order { [CCode (cname = "LLVMByteOrder", cheader_filename = "llvm-c/Target.h")] get; }
		[CCode (cname = "LLVMSizeOfTypeInBits", cheader_filename = "llvm-c/Target.h")]
		public uint size_of_type_in_bits (Ty ty);
		[CCode (cname = "LLVMStoreSizeOfType", cheader_filename = "llvm-c/Target.h")]
		public uint store_size_of_type (Ty ty);
		[CCode (cname = "LLVMABISizeOfType", cheader_filename = "llvm-c/Target.h")]
		public uint abi_size_of_type (Ty ty);
		[CCode (cname = "LLVMABIAlignmentOfType", cheader_filename = "llvm-c/Target.h")]
		public uint abi_alignment_of_type (Ty ty);
		[CCode (cname = "LLVMCallFrameAlignmentOfType", cheader_filename = "llvm-c/Target.h")]
		public uint call_frame_alignment_of_type (Ty ty);
		[CCode (cname = "LLVMElementAtOffset", cheader_filename = "llvm-c/Target.h")]
		public uint element_at_offset (Ty struct_ty, uint offset);
		[CCode (cname = "LLVMPreferredAlignmentOfGlobal", cheader_filename = "llvm-c/Target.h")]
		public uint preferred_alignment_of_global (GlobalVariable global_var);
		[CCode (cname = "LLVMPreferredAlignmentOfType", cheader_filename = "llvm-c/Target.h")]
		public uint preferred_alignment_of_type (Ty ty);
	}

	[SimpleType]
	[CCode (cname="LLVMTypeRef", has_type_id = false)]
	public struct Ty {
		/* array */
		[CCode (cname = "LLVMArrayType")]
		public static Ty array (Ty element_type, uint element_count);
		/* double */
		[CCode (cname = "LLVMDoubleType")]
		public static Ty double ();
		/* fp128 */
		[CCode (cname = "LLVMFP128Type")]
		public static Ty fp128 ();
		/* float */
		[CCode (cname = "LLVMFloatType")]
		public static Ty float ();
		/* function */
		[CCode (cname = "LLVMFunctionType")]
		public static Ty function (Ty return_type, [CCode (array_length_pos = 2.9)] Ty[] param_types, bool is_var_arg = false);
		[CCode (cname = "LLVMInt16Type")]
		public static Ty int16 ();
		[CCode (cname = "LLVMInt1Type")]
		public static Ty int1 ();
		[CCode (cname = "LLVMInt32Type")]
		public static Ty int32 ();
		[CCode (cname = "LLVMInt64Type")]
		public static Ty int64 ();
		[CCode (cname = "LLVMInt8Type")]
		public static Ty int8 ();
		[CCode (cname = "LLVMIntPtrType", cheader_filename="llvm-c/Target.h")]
		public static Ty int_ptr (TargetData p1);
		[CCode (cname = "LLVMIntType")]
		public static Ty int (uint num_bits);
		[CCode (cname = "LLVMLabelType")]
		public static Ty label ();
		[CCode (cname = "LLVMPPCFP128Type")]
		public static Ty ppcfp128 ();
		[CCode (cname = "LLVMPointerType")]
		public static Ty pointer (Ty element_type, uint address_space = 0);
		[CCode (cname = "LLVMStructType")]
		public static Ty struct (Ty[] element_types, bool packed);
		[CCode(cname = "LLVMStructCreateNamed")]
		public static Ty struct_named(Context C, string name);
		[CCode (cname = "LLVMVectorType")]
		public static Ty vector (Ty element_type, uint element_count);
		[CCode (cname = "LLVMVoidType")]
		public static Ty void ();
		[CCode (cname = "LLVMX86FP80Type")]
		public static Ty x86fp80 ();

		public uint array_length { [CCode (cname = "LLVMGetArrayLength")] get; }
		public bool is_function_var_arg { [CCode (cname = "LLVMIsFunctionVarArg")] get; }
		public bool is_sized { [CCode (cname = "LLVMTypeIsSized")] get; }
		public bool is_opaque_struct { [CCode (cname = "LLVMIsOpaqueStruct")] get; }
		public Ty return_type { [CCode (cname = "LLVMGetReturnType")] get; }
		public string struct_name { [CCode (cname = "LLVMGetStructName")] get; }
		public uint param_count { [CCode (cname = "LLVMCountParamTypes")] get; }

		public uint pointer_address_space { [CCode (cname = "LLVMGetPointerAddressSpace")] get; }
		public uint struct_element_count { [CCode (cname = "LLVMCountStructElementTypes")] get; }
		public bool is_packed_struct { [CCode (cname = "LLVMIsPackedStruct")] get; }
		public uint vector_size { [CCode (cname = "LLVMGetVectorSize")] get; }
		public Ty element_type { [CCode (cname = "LLVMGetElementType")] get; }
		public TypeKind kind { [CCode (cname = "LLVMGetTypeKind")] get; }
		public Context context { [CCode (cname = "LLVMGetTypeContext")] get; }
		public Value size { [CCode (cname = "LLVMSizeOf")] get; }
		public uint int_width { [CCode (cname = "LLVMGetIntTypeWidth")] get; }

		[CCode (cname = "LLVMGetParamTypes")]
		public void get_param_types ([CCode(array_length = false)] Ty[] dest);
		[CCode (cname = "LLVMGetStructElementTypes")]
		public void get_struct_element_types ([CCode(array_length = false)] Ty[] Dest);
		[CCode(cname = "LLVMStructSetBody")]
		public void set_struct_body(Ty[] elements, bool packed);
		[CCode(cname = "LLVMConstNamedStruct")]
		public Value const_named_struct(Value[] constant_vals);
}

	[SimpleType]
	[CCode (cname="LLVMUseRef", has_type_id = false)]
	public struct UseIterator {
		[CCode (cname = "LLVMGetNextUse")]
		public UseIterator? next_value ();

		public LLVM.Value used_value { [CCode (cname = "LLVMGetUsedValue")] get; }
		public LLVM.Value user { [CCode (cname = "LLVMGetUser")] get; }
	}

	/**
	 * LLVM Value Representation.
	 *
	 * This is a very important LLVM class. It is the base class of all values
	 * computed by a program that may be used as operands to other values. Value
	 * is the super class of other important classes such as {@link Instruction}
	 * and {@link Function}. All Values have a {@link Ty}. Type is not a
	 * subclass of Value. Some values can have a name and they belong to some
	 * Module. Setting the name on the Value automatically updates the module's
	 * symbol table.
	 *
	 * Every value has a "use list" that keeps track of which other Values are
	 * using this Value. A Value can also have an arbitrary number of ValueHandle
	 * objects that watch it and listen to RAUW and Destroy events. See
	 * llvm/Support/ValueHandle.h for details.
	 */
	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class Value {
		public string name {
			[CCode (cname = "LLVMGetValueName")]
			get;
			[CCode (cname = "LLVMSetValueName")]
			set;
		}
		public Ty type_of { [CCode (cname = "LLVMTypeOf")] get; }
		[CCode (cname = "LLVMDumpValue")]
		public void dump ();
		[CCode (cname = "LLVMReplaceAllUsesWith")]
		public void replace_all_use_with (Value new_val);
		[CCode (cname = "LLVMGetFirstUse")]
		public UseIterator iterator ();

		public bool is_a_alloca_inst { [CCode (cname = "LLVMIsAAllocaInst")] get; }
		public bool is_a_argument { [CCode (cname = "LLVMIsAArgument")] get; }
		public bool is_a_basic_block { [CCode (cname = "LLVMIsABasicBlock")] get; }
		public bool is_a_binary_operator { [CCode (cname = "LLVMIsABinaryOperator")] get; }
		public bool is_a_bit_cast_inst { [CCode (cname = "LLVMIsABitCastInst")] get; }
		public bool is_a_branch_inst { [CCode (cname = "LLVMIsABranchInst")] get; }
		public bool is_a_call_inst { [CCode (cname = "LLVMIsACallInst")] get; }
		public bool is_a_cast_inst { [CCode (cname = "LLVMIsACastInst")] get; }
		public bool is_a_cmp_inst { [CCode (cname = "LLVMIsACmpInst")] get; }
		public bool is_a_constant { [CCode (cname = "LLVMIsAConstant")] get; }
		public bool is_a_constant_aggregate_zero { [CCode (cname = "LLVMIsAConstantAggregateZero")] get; }
		public bool is_a_constant_array { [CCode (cname = "LLVMIsAConstantArray")] get; }
		public bool is_a_constant_expr { [CCode (cname = "LLVMIsAConstantExpr")] get; }
		public bool is_a_constant_fp { [CCode (cname = "LLVMIsAConstantFP")] get; }
		public bool is_a_constant_int { [CCode (cname = "LLVMIsAConstantInt")] get; }
		public bool is_a_constant_pointer_null { [CCode (cname = "LLVMIsAConstantPointerNull")] get; }
		public bool is_a_constant_struct { [CCode (cname = "LLVMIsAConstantStruct")] get; }
		public bool is_a_constant_vector { [CCode (cname = "LLVMIsAConstantVector")] get; }
		public bool is_a_dbg_declare_inst { [CCode (cname = "LLVMIsADbgDeclareInst")] get; }
		public bool is_a_dbg_func_start_inst { [CCode (cname = "LLVMIsADbgFuncStartInst")] get; }
		public bool is_a_dbg_info_intrinsic { [CCode (cname = "LLVMIsADbgInfoIntrinsic")] get; }
		public bool is_a_dbg_region_end_inst { [CCode (cname = "LLVMIsADbgRegionEndInst")] get; }
		public bool is_a_dbg_region_start_inst { [CCode (cname = "LLVMIsADbgRegionStartInst")] get; }
		public bool is_a_dbg_stop_point_inst { [CCode (cname = "LLVMIsADbgStopPointInst")] get; }
		public bool is_a_eh_selector_inst { [CCode (cname = "LLVMIsAEHSelectorInst")] get; }
		public bool is_a_eh_exception_inst { [CCode (cname = "LLVMIsAEHExceotionInst")] get; }
		public bool is_a_extract_element_inst { [CCode (cname = "LLVMIsAExtractElementInst")] get; }
		public bool is_a_extract_value_inst { [CCode (cname = "LLVMIsAExtractValueInst")] get; }
		public bool is_a_fcmp_inst { [CCode (cname = "LLVMIsAFCmpInst")] get; }
		public bool is_a_fp_ext_inst { [CCode (cname = "LLVMIsAFPExtInst")] get; }
		public bool is_a_fp_to_si_inst { [CCode (cname = "LLVMIsAFPToSIInst")] get; }
		public bool is_a_fp_to_ui_inst { [CCode (cname = "LLVMIsAFPToUIInst")] get; }
		public bool is_a_fp_trunc_inst { [CCode (cname = "LLVMIsAFPTruncInst")] get; }
		public bool is_a_function { [CCode (cname = "LLVMIsAFunction")] get; }
		public bool is_a_get_element_ptr_inst { [CCode (cname = "LLVMIsAGetElementPtrInst")] get; }
		public bool is_a_global_alias { [CCode (cname = "LLVMIsAGlobalAlias")] get; }
		public bool is_a_global_value { [CCode (cname = "LLVMIsAGlobalValue")] get; }
		public bool is_a_global_variable { [CCode (cname = "LLVMIsAGlobalVariable")] get; }
		public bool is_a_icmp_inst { [CCode (cname = "LLVMIsAICmpInst")] get; }
		public bool is_a_inline_asm { [CCode (cname = "LLVMIsAInlineAsm")] get; }
		public bool is_a_md_node { [CCode (cname = "LLVMIsAMDNode")] get; }
		public bool is_a_md_string { [CCode (cname = "LLVMIsAMDString")] get; }
		public bool is_a_insert_element_inst { [CCode (cname = "LLVMIsAInsertElementInst")] get; }
		public bool is_a_insert_value_inst { [CCode (cname = "LLVMIsAInsertValueInst")] get; }
		public bool is_a_landing_pad_inst { [CCode (cname = "LLVMIsALandingPadInst")] get; }
		public bool is_a_instruction { [CCode (cname = "LLVMIsAInstruction")] get; }
		public bool is_a_int_to_ptr_inst { [CCode (cname = "LLVMIsAIntToPtrInst")] get; }
		public bool is_a_intrinsic_inst { [CCode (cname = "LLVMIsAIntrinsicInst")] get; }
		public bool is_a_invoke_inst { [CCode (cname = "LLVMIsAInvokeInst")] get; }
		public bool is_a_load_inst { [CCode (cname = "LLVMIsALoadInst")] get; }
		public bool is_a_mem_cpy_inst { [CCode (cname = "LLVMIsAMemCpyInst")] get; }
		public bool is_a_mem_intrinsic { [CCode (cname = "LLVMIsAMemIntrinsic")] get; }
		public bool is_a_mem_move_inst { [CCode (cname = "LLVMIsAMemMoveInst")] get; }
		public bool is_a_mem_set_inst { [CCode (cname = "LLVMIsAMemSetInst")] get; }
		public bool is_a_phi_node { [CCode (cname = "LLVMIsAPHINode")] get; }
		public bool is_a_ptr_to_int_inst { [CCode (cname = "LLVMIsAPtrToIntInst")] get; }
		public bool is_a_return_inst { [CCode (cname = "LLVMIsAReturnInst")] get; }
		public bool is_a_sext_inst { [CCode (cname = "LLVMIsASExtInst")] get; }
		public bool is_a_si_to_fp_inst { [CCode (cname = "LLVMIsASIToFPInst")] get; }
		public bool is_a_select_inst { [CCode (cname = "LLVMIsASelectInst")] get; }
		public bool is_a_shuffle_vector_inst { [CCode (cname = "LLVMIsAShuffleVectorInst")] get; }
		public bool is_a_store_inst { [CCode (cname = "LLVMIsAStoreInst")] get; }
		public bool is_a_switch_inst { [CCode (cname = "LLVMIsASwitchInst")] get; }
		public bool is_a_terminator_inst { [CCode (cname = "LLVMIsATerminatorInst")] get; }
		public bool is_a_trunc_inst { [CCode (cname = "LLVMIsATruncInst")] get; }
		public bool is_a_ui_to_fp_inst { [CCode (cname = "LLVMIsAUIToFPInst")] get; }
		public bool is_a_unary_instruction { [CCode (cname = "LLVMIsAUnaryInstruction")] get; }
		public bool is_a_undef_value { [CCode (cname = "LLVMIsAUndefValue")] get; }
		public bool is_a_unreachable_inst { [CCode (cname = "LLVMIsAUnreachableInst")] get; }
		public bool is_a_resume_inst { [CCode (cname = "LLVMIsAResumeInst")] get; }
		public bool is_a_user { [CCode (cname = "LLVMIsAUser")] get; }
		public bool is_a_va_arg_inst { [CCode (cname = "LLVMIsAVAArgInst")] get; }
		public bool is_a_zext_inst { [CCode (cname = "LLVMIsAZExtInst")] get; }

		public bool is_constant { [CCode (cname = "LLVMIsConstant")] get; }
		public bool is_block_address { [CCode (cname = "LLVMIsBlockAddress")] get; }
		public bool is_declaration { [CCode (cname = "LLVMIsDeclaration")] get; }
		public bool is_global_constant { [CCode (cname = "LLVMIsGlobalConstant")] get; }
		public bool is_null { [CCode (cname = "LLVMIsNull")] get; }
		public bool is_tail_call { [CCode (cname = "LLVMIsTailCall")] get; }
		public bool is_thread_local { [CCode (cname = "LLVMIsThreadLocal")] get; }
		public bool is_undef { [CCode (cname = "LLVMIsUndef")] get; }
		public bool is_basic_block { [CCode (cname = "LLVMValueIsBasicBlock")] get; }

		public uint8[] md_string {
			[CCode(cname = "LLVMGetMDString")]
			get;
		}
		public int md_node_operands {
			[CCode(cname = "LLVMGetMDNodeNumOperands")]
			get;
		}

		[CCode (cname = "LLVMValueAsBasicBlock")]
		public BasicBlock as_basic_block ();
		[CCode(cname = "LLVMGetMDNodeOperand")]
		public Value *get_md_node_operand(uint i);
	}

	[SimpleType]
	[CCode (cname="LLVMBasicBlockRef", has_type_id = false)]
	public struct BasicBlock {
		public Value parent { [CCode (cname = "LLVMGetBasicBlockParent")] get; }
		public Value @value { [CCode (cname = "LLVMBasicBlockAsValue")] get; }
		public BasicBlock next { [CCode (cname = "LLVMGetNextBasicBlock")] get; }
		public BasicBlock previous { [CCode (cname = "LLVMGetPreviousBasicBlock")] get; }

		public Instruction first_instruction { [CCode (cname = "LLVMGetFirstInstruction")] get; }
		public Instruction last_instruction { [CCode (cname = "LLVMGetLastInstruction")] get; }

		[CCode(cname = "LLVMDeleteBasicBlock")]
		[DestroysInstance]
		public void delete();
		[CCode (cname = "LLVMInsertBasicBlock")]
		public BasicBlock insert_before (string name);
		[CCode(cname = "LLVMGetBasicBlockTerminator")]
		public Value get_terminator();
		[CCode(cname = "LLVMRemoveBasicBlockFromParent")]
		public void remove_from_parent();
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class User: Value {
		public int count { [CCode(cname = "LLVMGetNumOperands")] get; }
		[CCode (cname = "LLVMSetOperand")]
		public Value get(uint index);
		[CCode (cname = "LLVMGetOperand")]
		public Value set(uint index, Value val);
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class Instruction: User {
		public BasicBlock parent { [CCode (cname = "LLVMGetInstructionParent")] get; }
		public Instruction next { [CCode (cname = "LLVMGetNextInstruction")] get; }
		public Instruction previous { [CCode (cname = "LLVMGetPreviousInstruction")] get; }
		public Opcode opcode { [CCode (cname = "LLVMGetInstructionOpcode")] get; }
		public IntPredicate icmp_predicate { [CCode (cname = "LLVMGetICmpPredicate")] get; }
		[CCode(cname = "LLVMInstructionEraseFromParent")]
		public void erase_from_parent();
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class CmpInst: Instruction {
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class ICmpInst: CmpInst {
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class FCmpInst: CmpInst {
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class ReturnInst: Instruction {
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class BranchInst: Instruction {
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class SwitchInst: Instruction {
		public BasicBlock default_dest { [CCode(cname = "LLVMGetSwitchDefaultDest")] get; }
		[CCode (cname = "LLVMAddCase")]
		public void add_case (Value on_val, BasicBlock dest);
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class InvokeInst: Instruction {
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class LandingPadInst: Instruction {
		/**
		 * Add a catch or filter clause to the landingpad instruction
		 */
		[CCode(cname = "LLVMAddClause")]
		public void add_clause(Value clause_val);
		/**
		 * Set the 'cleanup' flag in the landingpad instruction
		 */
		[CCode(cname = "LLVMSetCleanup")]
		void set_cleanup(bool val);
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class UnreachableInst: Instruction {
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class UnaryInst: Instruction {
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class AllocaInst: UnaryInst {
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class LoadInst: UnaryInst {
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class CastInst: UnaryInst {
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class StoreInst: Instruction {
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class GEPInst: Instruction {
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class SelectInst: Instruction {
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class VAArgInst: Instruction {
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class ExtractElementInst: Instruction {
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class InsertElementInst: Instruction {
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class ShuffleVectorInst: Instruction {
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class ExtractValueInst: Instruction {
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class InsertValueInst: Instruction {
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class CallInst: Instruction {
		public CallConv call_conv {
			[CCode (cname = "LLVMSetInstructionCallConv")]
			set;
			[CCode (cname = "LLVMGetInstructionCallConv")]
			get;
		}

		[CCode (cname = "LLVMAddInstrAttribute")]
		public void add_attribute (uint index, Attribute attr);
		[CCode (cname = "LLVMRemoveInstrAttribute")]
		public void remove_attribute (uint index, Attribute attr);
		[CCode (cname = "LLVMSetInstrParamAlignment")]
		public void set_alignment (uint index, uint align);

		public bool is_tail_call {
			[CCode (cname = "LLVMIsTailCall")]
			get;
			[CCode (cname = "LLVMSetTailCall")]
			set;
		}
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class PHINode: Instruction {
		[CCode (cname = "LLVMAddIncoming")]
		public void add_incoming ([CCode (array_length_pos = 3.9)] LLVM.Value[] incoming_values, [CCode (array_length = false)] BasicBlock[] incoming_blocks);
		public uint incoming_count { [CCode (cname = "LLVMCountIncoming")] get; }
		[CCode (cname = "LLVMGetIncomingValue")]
		public LLVM.Value get_incoming_value (uint index);
		[CCode (cname = "LLVMGetIncomingBlock")]
		public LLVM.BasicBlock get_incoming_block (uint index);
	}

	// FIXME: Argument or Parameter - there is a mix in the bindings
	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class Argument: Value {
		public Function parent { [CCode (cname = "LLVMGetParamParent")] get; }
		public Attribute attribute { [CCode (cname = "LLVMGetAttribute")] get; }
		public Argument next { [CCode (cname = "LLVMGetNextParam")] get; }
		public Argument previous { [CCode (cname = "LLVMGetPreviousParam")] get; }

		[CCode (cname = "LLVMAddAttribute")]
		public void add_attribute (Attribute pa);
		[CCode (cname = "LLVMRemoveAttribute")]
		public void remove_attribute (Attribute pa);
		[CCode (cname = "LLVMSetParamAlignment")]
		public void set_alignment (uint align);
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class Constant: User {
		public LLVM.Opcode opcode { [CCode (cname = "LLVMGetConstOpcode")] get; }
		public int64 sext_value { [CCode (cname = "LLVMConstIntGetSExtValue")] get; }
		public uint64 zext_value { [CCode (cname = "LLVMConstIntGetZExtValue")] get; }
		[ccode (cname = "LLVMConstIntToPtr")]
		public Constant to_ptr (LLVM.Ty to_type);

		[CCode (cname = "LLVMConstInt")]
		public static Constant int (LLVM.Ty ty, uint64 n, bool sign_extend);
		[CCode (cname = "LLVMConstIntCast")]
		public static Constant int_cast (LLVM.Value constant_val, LLVM.Ty to_type, bool is_signed);
		[CCode (cname = "LLVMConstIntOfString")]
		public static Constant int_from_string (LLVM.Ty int_ty, string text, uint8 radix);
		[CCode (cname = "LLVMConstIntOfStringAndSize")]
		public static Constant int_from_array (LLVM.Ty int_ty, uint8[] text, uint8 radix);
		[CCode (cname = "LLVMConstReal")]
		public static Constant real (LLVM.Ty real_ty, double n);
		[CCode (cname = "LLVMConstRealOfString")]
		public static Constant real_from_string (LLVM.Ty real_ty, string text);
		[CCode (cname = "LLVMConstRealOfStringAndSize")]
		public static Constant real_from_array (LLVM.Ty real_ty, uint8[] text);

		[CCode (cname = "LLVMConstNull")]
		public static Constant @null (LLVM.Ty ty);
		[CCode (cname = "LLVMConstAllOnes")]
		public static Constant all_ones (LLVM.Ty Ty);
		[CCode (cname = "LLVMGetUndef")]
		public static Constant undef (LLVM.Ty ty);
		[CCode (cname = "LLVMConstPointerNull")]
		public static Constant pointer_null (LLVM.Ty ty);

		[CCode (cname = "LLVMConstString")]
		public static Constant @string (uint8[] str, bool dont_null_terminate);

		[CCode (cname = "LLVMConstStruct")]
		public static Constant @struct (Value[] constant_vals, bool packed);

		[CCode (cname = "LLVMConstArray")]
		public static Constant array (LLVM.Ty element_ty, LLVM.Value[] constant_vals);
		[CCode (cname = "LLVMConstVector")]
		public static Constant vector (LLVM.Value[] scalar_constant_vals);

		[CCode (cname = "LLVMAlignOf")]
		public static Constant align_of (LLVM.Ty ty);
		[CCode (cname = "LLVMSizeOf")]
		public static Constant size_of (LLVM.Ty ty);
		[CCode (cname = "LLVMConstNeg")]
		public static Constant neg (LLVM.Value constant_val);
		[CCode (cname = "LLVMConstFNeg")]
		public static Constant fneg (LLVM.Value constant_val);
		[ccode (cname = "LLVMConstNot")]
		public static Constant not (LLVM.Value constant_val);
		[ccode (cname = "LLVMConstAdd")]
		public static Constant add (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstNSWAdd")]
		public static Constant nswadd (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstFAdd")]
		public static Constant fadd (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstSub")]
		public static Constant sub (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstFSub")]
		public static Constant fsub (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstMul")]
		public static Constant mul (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstFMul")]
		public static Constant fmul (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstUDiv")]
		public static Constant udiv (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstSDiv")]
		public static Constant sdiv (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstExactSDiv")]
		public static Constant exact_sdiv (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstFDiv")]
		public static Constant fdiv (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstURem")]
		public static Constant urem (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstSRem")]
		public static Constant srem (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstFRem")]
		public static Constant frem (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstAnd")]
		public static Constant and (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstOr")]
		public static Constant or (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[ccode (cname = "LLVMConstXor")]
		public static Constant xor (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[CCode (cname = "LLVMConstICmp")]
		public static Constant icmp (LLVM.IntPredicate predicate, LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[CCode (cname = "LLVMConstFCmp")]
		public static Constant fcmp (LLVM.IntPredicate predicate, LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[CCode (cname = "LLVMConstShl")]
		public static Constant shl (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[CCode (cname = "LLVMConstLShr")]
		public static Constant lshr (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[CCode (cname = "LLVMConstAShr")]
		public static Constant ashr (LLVM.Value lhs_constant, LLVM.Value rhs_constant);
		[CCode (cname = "LLVMConstGEP")]
		public static Constant gep (LLVM.Value constant_val, LLVM.Value constant_indices, uint num_indices);
		[CCode (cname = "LLVMConstInBoundsGEP")]
		public static Constant in_bounds_gep (LLVM.Value constant_val, LLVM.Value constant_indices, uint num_indices);
		[CCode (cname = "LLVMConstTrunc")]
		public static Constant trunc (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstSExt")]
		public static Constant sext (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstZExt")]
		public static Constant zext (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstFPTrunc")]
		public static Constant fptrunc (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstFPExt")]
		public static Constant fpext (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstUIToFP")]
		public static Constant ui_to_fp (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstSIToFP")]
		public static Constant si_to_fp (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstFPToUI")]
		public static Constant fp_to_ui (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstFPToSI")]
		public static Constant fp_to_si (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstPtrToInt")]
		public static Constant ptr_to_int (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstBitCast")]
		public static Constant bit_cast (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstZExtOrBitCast")]
		public static Constant zext_or_bit_cast (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstSExtOrBitCast")]
		public static Constant sext_or_bit_cast (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstTruncOrBitCast")]
		public static Constant trunc_or_bit_cast (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstPointerCast")]
		public static Constant pointer_cast (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstFPCast")]
		public static Constant fp_cast (LLVM.Value constant_val, LLVM.Ty to_type);
		[CCode (cname = "LLVMConstSelect")]
		public static Constant select (Value constant_condition, LLVM.Value constant_if_true, LLVM.Value constant_if_false);
		[CCode (cname = "LLVMConstExtractElement")]
		public static Constant extract_element (LLVM.Value vector_constant, LLVM.Value index_constant);
		[CCode (cname = "LLVMConstInsertElement")]
		public static Constant insert_element (LLVM.Value vector_constant, LLVM.Value element_value_constant, LLVM.Value index_constant);
		[CCode (cname = "LLVMConstShuffleVector")]
		public static Constant shuffle_vector (LLVM.Value vector_constant, LLVM.Value vector_b_constant, LLVM.Value mask_constant);
		[CCode (cname = "LLVMConstExtractValue")]
		public static Constant extract_value (LLVM.Value agg_constant, uint[] idx_list);
		[CCode (cname = "LLVMConstInsertValue")]
		public static Constant insert_value (LLVM.Value agg_constant, LLVM.Value element_value_constant, uint[] idx_list);
		[CCode (cname = "LLVMConstInlineAsm")]
		public static Constant inline_asm (LLVM.Ty ty, string asm_string, string constraints, bool has_side_effects);
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class GlobalValue: Constant {
		public Module global_parent { [CCode (cname = "LLVMGetGlobalParent")] get; }
		public Linkage linkage {
			[CCode (cname = "LLVMGetLinkage")]
			get;
			[CCode (cname = "LLVMSetLinkage")]
			set;
		}
		public string section {
			[CCode (cname = "LLVMGetSection")]
			get;
			[CCode (cname = "LLVMSetSection")]
			set;
		}
		public Visibility visibility {
			[CCode (cname = "LLVMGetVisibility")]
			get;
			[CCode (cname = "LLVMSetVisibility")]
			set;
		}
		public uint alignment {
			[CCode (cname = "LLVMGetAlignment")]
			get;
			[CCode (cname = "LLVMSetAlignment")]
			set;
		}
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class GlobalVariable: GlobalValue {
		public GlobalVariable next { [CCode (cname = "LLVMGetNextGlobal")] get; }
		public GlobalVariable previous { [CCode (cname = "LLVMGetPreviousGlobal")] set; }
		[CCode (cname = "LLVMDeleteGlobal")]
		[DestroysInstance]
		public void delete ();

		public Constant initializer {
			[CCode (cname = "LLVMGetInitializer")]
			get;
			[CCode (cname = "LLVMSetInitializer")]
			set;
		}

		public bool is_thread_local {
			[CCode (cname = "LLVMSetGlobalConstant")]
			get;
			[CCode (cname = "LLVMSetThreadLocal")]
			set;
		}
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class GlobalAlias: GlobalValue {
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class Function: GlobalValue {
		public Attribute attribute {
			[CCode (cname = "LLVMGetFunctionAttr")]
			get;
		}
		public FunctionParams param { [CCode(cname = "")] get; }
		public FunctionBlocks blocks { [CCode(cname = "")] get; }
		public uint intrinsic_id { [CCode (cname = "LLVMGetIntrinsicID")] get; }
		public CallConv call_conv {
			[CCode (cname = "LLVMGetFunctionCallConv")]
			get;
			[CCode (cname = "LLVMSetFunctionCallConv")]
			set;
		}
		public string gc {
			[CCode (cname = "LLVMGetGC")]
			get;
			[CCode (cname = "LLVMSetGC")]
			set;
		}
		public Function next { [CCode (cname = "LLVMGetNextFunction")] get; }
		public Function previous { [CCode (cname = "LLVMGetPreviousFunction")] get; }

		[CCode (cname = "LLVMAppendBasicBlock")]
		public BasicBlock append(string name);
		[CCode (cname = "LLVMDeleteFunction")]
		[DestroysInstance]
		public void delete ();
		[CCode (cname = "LLVMAddFunctionAttr")]
		public void add_attribute (LLVM.Attribute pa);
		[CCode (cname = "LLVMRemoveFunctionAttr")]
		public void remove_attribute (LLVM.Attribute pa);
		[CCode (cname = "LLVMVerifyFunction", cheader_filename = "llvm-c/Analysis.h")]
		public int verify (VerifierFailureAction action);
		[CCode (cname = "LLVMViewFunctionCFG", cheader_filename = "llvm-c/Analysis.h")]
		public void view_cfg ();
		[CCode (cname = "LLVMViewFunctionCFGOnly", cheader_filename = "llvm-c/Analysis.h")]
		public void view_cfg_only ();
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class FunctionParams {
		public uint count { [CCode (cname = "LLVMCountParams")] get; }
		[CCode (cname = "LLVMGetParams")]
		public void get_all ([CCode(array_length = false) ]Value[] param_list);
		[CCode (cname = "LLVMGetParam")]
		public Value get (uint index);

		public Argument first { [CCode (cname = "LLVMGetFirstParam")] get; }
		public Argument last { [CCode (cname = "LLVMGetLastParam")] get; }
	}

	[CCode(cname = "struct LLVMOpaqueValue", ref_function = "", unref_function = "", has_type_id = false)]
	public class FunctionBlocks {
		public uint count { [CCode (cname = "LLVMCountBasicBlocks")] get; }
		[CCode (cname = "LLVMGetBasicBlocks")]
		public void get_all ([CCode(array_length = false)] BasicBlock[] basic_blocks);
		public BasicBlock first { [CCode (cname = "LLVMGetFirstBasicBlock")] get; }
		public BasicBlock last { [CCode (cname = "LLVMGetLastBasicBlock")] get; }
		public BasicBlock entry { [CCode (cname = "LLVMGetEntryBasicBlock")] get; }
	}

	[Flags]
	[CCode (cprefix = "", has_type_id = "0")]
	public enum Attribute {
		[CCode (cname="LLVMZExtAttribute")]
		Z_EXT,
		[CCode (cname="LLVMSExtAttribute")]
		EXT,
		[CCode (cname="LLVMNoReturnAttribute")]
		NO_RETURN,
		[CCode (cname="LLVMInRegAttribute")]
		IN_REG,
		[CCode (cname="LLVMStructRetAttribute")]
		STRUCT_RET,
		[CCode (cname="LLVMNoUnwindAttribute")]
		NO_UNWIND,
		[CCode (cname="LLVMNoAliasAttribute")]
		NO_ALIAS,
		[CCode (cname="LLVMByValAttribute")]
		BY_VAL,
		[CCode (cname="LLVMNestAttribute")]
		NEST,
		[CCode (cname="LLVMReadNoneAttribute")]
		READ_NONE,
		[CCode (cname="LLVMReadOnlyAttribute")]
		READ_ONLY,
		[CCode (cname="LLVMNoInlineAttribute")]
		NO_INLINE,
		[CCode (cname="LLVMAlwaysInlineAttribute")]
		ALWAYS_INLINE,
		[CCode (cname="LLVMOptimizeForSizeAttribute")]
		OPTIMIZE_FOR_SIZE,
		[CCode (cname="LLVMStackProtectAttribute")]
		STACK_PROTECT,
		[CCode (cname="LLVMStackProtectReqAttribute")]
		PROTECT_REQ,
		[CCode (cname="LLVMNoCaptureAttribute")]
		NO_CAPTURE,
		[CCode (cname="LLVMNoRedZoneAttribute")]
		NO_RED_ZONE,
		[CCode (cname="LLVMNoImplicitFloatAttribute")]
		NO_IMPLICIT_FLOAT,
		[CCode (cname="LLVMNakedAttribute")]
		NAKED,
		[CCode (cname="LLVMInlineHintAttribute")]
		INLINE_HINT,
		[CCode (cname="LLVMStackAlignment")]
		STACK_ALIGNMENT,
		[CCode (cname="LLVMReturnsTwice")]
		RETURNS_TWICE,
		[CCode (cname="LLVMUWTable")]
		UW_TABLE,
		[CCode (cname="LLVMNonLazyBind")]
		NON_LAZY_BIND
	}

	[CCode (cprefix = "", has_type_id = "0")]
	public enum CallConv {
		[CCode (cname="LLVMCCallConv")]
		C,
		[CCode (cname="LLVMFastCallConv")]
		FAST,
		[CCode (cname="LLVMColdCallConv")]
		COLD,
		[CCode (cname="LLVMX86StdcallCallConv")]
		STD,
		[CCode (cname="LLVMX86FastcallCallConv")]
		X86FAST
	}

	[CCode (cprefix = "LLVMInt", has_type_id = "0")]
	public enum IntPredicate {
		EQ,
		NE,
		UGT,
		UGE,
		ULT,
		ULE,
		SGT,
		SGE,
		SLT,
		SL
	}
	[CCode(cname = "LLVMLandingPadClauseTy", cprefix = "")]
	public enum LandingPadClause {
		[CCode(cname = "LLVMLandingPadCatch")]
		CATCH,
		[CCode(cname = "LLVMLandingPadFilter")]
		FILTER
	}
	[CCode (cprefix = "", has_type_id = "0")]
	public enum Linkage {
		[CCode (cname="LLVMExternalLinkage")]
		EXTERNAL,
		[CCode (cname="LLVMAvailableExternallyLinkage")]
		AVAILABLE_EXTERNALLY,
		[CCode (cname="LLVMLinkOnceAnyLinkage")]
		LINK_ONCE_ANY,
		[CCode (cname="LLVMLinkOnceODRLinkage")]
		LINK_ONCE_ODR,
		[CCode (cname="LLVMWeakAnyLinkage")]
		WEAK_ANY,
		[CCode (cname="LLVMWeakODRLinkage")]
		WEAK_ODR,
		[CCode (cname="LLVMAppendingLinkage")]
		APPENDING,
		[CCode (cname="LLVMInternalLinkage")]
		INTERNAL,
		[CCode (cname="LLVMPrivateLinkage")]
		PRIATE,
		[CCode (cname="LLVMDLLImportLinkage")]
		DLL_IMPORT,
		[CCode (cname="LLVMDLLExportLinkage")]
		DLL_EXPORT,
		[CCode (cname="LLVMExternalWeakLinkage")]
		EXTERNAL_WEAK,
		[CCode (cname="LLVMGhostLinkage")]
		GHOST,
		[CCode (cname="LLVMCommonLinkage")]
		COMMON,
		[CCode (cname="LLVMLinkerPrivateLinkage")]
		LINKER_PRIVATE
	}

	[CCode (cname = "LLVMOpcode", cprefix = "LLVM", has_type_id = "0")]
	public enum Opcode {
		Ret,
		Br,
		Switch,
		Invoke,
		Unreachable,
		Add,
		FAdd,
		Sub,
		FSub,
		Mul,
		FMul,
		UDiv,
		SDiv,
		FDiv,
		URem,
		SRem,
		FRem,
		Shl,
		LShr,
		AShr,
		And,
		Or,
		Xor,
		Malloc,
		Free,
		Alloca,
		Load,
		Store,
		GetElementPtr,
		Trunk,
		ZExt,
		SExt,
		FPToUI,
		FPToSI,
		UIToFP,
		SIToFP,
		FPTrunc,
		FPExt,
		PtrToInt,
		IntToPtr,
		BitCast,
		ICmp,
		FCmp,
		PHI,
		Call,
		Select,
		VAArg,
		ExtractElement,
		InsertElement,
		ShuffleVector,
		ExtractValue,
		InsertValue,
		Fence,
		AtomicCmpXchg,
		AtomicRMW,
		Resume,
		LandingPad,
		Unwind
	}

	[CCode (cname = "LLVMRealPredicate", cprefix = "LLVMReal", has_type_id = "0")]
	public enum RealPredicate {
		[CCode (cname="LLVMRealPredicateFalse")]
		FALSE,
		OEQ,
		OGT,
		OGE,
		OLT,
		OLE,
		ONE,
		ORD,
		UNO,
		UEQ,
		UGT,
		UGE,
		ULT,
		ULE,
		UNE,
		[CCode (cname="LLVMRealPredicateTrue")]
		TRUE
	}

	[CCode (cname = "LLVMTypeKind", has_type_id = "0")]
	public enum TypeKind {
		[CCode (cname="LLVMVoidTypeKind")]
		VOID,
		[CCode (cname="LLVMFloatTypeKind")]
		FLOAT,
		[CCode (cname="LLVMDoubleTypeKind")]
		DOUBLE,
		[CCode (cname="LLVMX86_FP80TypeKind")]
		X86_FP80,
		[CCode (cname="LLVMFP128TypeKind")]
		FP128,
		[CCode (cname="LLVMPPC_FP128TypeKind")]
		PPC_FP128,
		[CCode (cname="LLVMLabelTypeKind")]
		LABEL,
		[CCode (cname="LLVMIntegerTypeKind")]
		INTEGER,
		[CCode (cname="LLVMFunctionTypeKind")]
		FUNCTION,
		[CCode (cname="LLVMStructTypeKind")]
		STRUCT,
		[CCode (cname="LLVMArrayTypeKind")]
		ARRAY,
		[CCode (cname="LLVMPointerTypeKind")]
		POINTER,
		[CCode (cname="LLVMVectorTypeKind")]
		VECTOR,
		[CCode (cname="LLVMMetadataTypeKind")]
		METADATA
	}

	[CCode (cheader_filename = "llvm-c/Analysis.h", cprefix = "", has_type_id = "0")]
	public enum VerifierFailureAction {
		[CCode (cname="LLVMAbortProcessAction")]
		ABORT_PROCESS,
		[CCode (cname="LLVMPrintMessageAction")]
		PRINT_MESSAGE,
		[CCode (cname="LLVMReturnStatusAction")]
		RETURN_STATUS
	}

	[CCode (cname = "LLVMVisibility", has_type_id = "0")]
	public enum Visibility {
		[CCode (cname="LLVMDefaultVisibility")]
		DEFAULT,
		[CCode (cname="LLVMHiddenVisibility")]
		HIDDEN,
		[CCode (cname="LLVMProtectedVisibility")]
		PROTECTED
	}

	[CCode (cname = "LLVMLinkInInterpreter")]
	public static void link_in_interpreter ();
	[CCode (cname = "LLVMLinkInJIT")]
	public static void link_in_jit ();

	[CCode (cname = "LLVMInitializeCppBackendTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_cpp_backend_target_info ();
	[CCode (cname = "LLVMInitializeCppBackendTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_cpp_backend_target ();
	[CCode (cname = "LLVMInitializeMSILTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_msil_target_info ();
	[CCode (cname = "LLVMInitializeMSILTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_msil_target ();
	[CCode (cname = "LLVMInitializeCBackendTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_c_backend_target_info ();
	[CCode (cname = "LLVMInitializeCBackendTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_c_backend_target ();
	[CCode (cname = "LLVMInitializeBlackfinTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_blackfin_target_info ();
	[CCode (cname = "LLVMInitializeBlackfinTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_blackfin_target ();
	[CCode (cname = "LLVMInitializeSystemZTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_systemz_target_info ();
	[CCode (cname = "LLVMInitializeSystemZTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_systemz_target ();
	[CCode (cname = "LLVMInitializeMSP430TargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_msp430_target_info ();
	[CCode (cname = "LLVMInitializeMSP430Target", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_msp430_target ();
	[CCode (cname = "LLVMInitializeXCoreTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_xcore_target_info ();
	[CCode (cname = "LLVMInitializeXCoreTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_xcore_target ();
	[CCode (cname = "LLVMInitializePIC16TargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_pic16_target_info ();
	[CCode (cname = "LLVMInitializePIC16Target", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_pic16_target ();
	[CCode (cname = "LLVMInitializeCellSPUTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_cell_spu_target_info ();
	[CCode (cname = "LLVMInitializeCellSPUTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_cell_spu_target ();
	[CCode (cname = "LLVMInitializeMipsTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_mips_target_info ();
	[CCode (cname = "LLVMInitializeMipsTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_mips_target ();
	[CCode (cname = "LLVMInitializeARMTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_arm_target_info ();
	[CCode (cname = "LLVMInitializeARMTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_arm_target ();
	[CCode (cname = "LLVMInitializeAlphaTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_alpha_target_info ();
	[CCode (cname = "LLVMInitializeAlphaTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_alpha_target ();
	[CCode (cname = "LLVMInitializePowerPCTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_powerpc_target_info ();
	[CCode (cname = "LLVMInitializePowerPCTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_powerpc_target ();
	[CCode (cname = "LLVMInitializeSparcTargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_sparc_target_info ();
	[CCode (cname = "LLVMInitializeSparcTarget", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_sparc_target ();
	[CCode (cname = "LLVMInitializeX86TargetInfo", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_x86_target_info ();
	[CCode (cname = "LLVMInitializeX86Target", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_x86_target ();

	[CCode (cname = "LLVMInitializeAllTargetInfos", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_all_target_infos ();
	/**
	 * The main program should call this function if it wants to link in all
	 * available targets that LLVM is configured to support.
	 */
	[CCode (cname = "LLVMInitializeAllTargets", cheader_filename = "llvm-c/Target.h")]
	public static void initialize_all_targets ();
	/**
	 * The main program should call this function to initialize the native target
	 * corresponding to the host.
	 *
	 * This is useful for JIT applications to ensure that the target gets linked
	 * in correctly.
	 * @return true if the native target is unavailable
	 */
	[CCode (cname = "LLVMInitializeNativeTarget", cheader_filename = "llvm-c/Target.h")]
	public static bool initialize_native_target ();

	[CCode (cheader_filename = "llvm-c/lto.h")]
	namespace LTO {
		[CCode (cname = "llvm_lto_status", cprefix = "LLVM_LTO_", has_type_id = "0", cheader_filename = "llvm-c/LinkTimeOptimizer.h")]
		public enum Status {
			UNKNOWN,
			OPT_SUCCESS,
			READ_SUCCESS,
			READ_FAILURE,
			WRITE_FAILURE,
			NO_TARGET,
			NO_WORK,
			MODULE_MERGE_FAILURE,
			ASM_FAILURE,
			NULL_OBJECT
		}

		[Compact]
		[CCode (cname="llvm_lto_t", free_function="llvm_destroy_optimizer", cheader_filename = "llvm-c/LinkTimeOptimizer.h", has_type_id = false)]
		public class Optimizer {
			[CCode (cname="llvm_create_optimizer")]
			public Optimizer ();
			[CCode (cname="llvm_optimize_modules")]
			public Status optimize_modules (string output_filename);
			[CCode (cname="llvm_read_object_file")]
			public Status read_object_file (string input_filename);
		}

		[Compact]
		[CCode (cname = "lto_code_gen_t", free_function = "lto_codegen_dispose", has_type_id = false)]
		public class CodeGen {
			[CCode (cname = "lto_codegen_create")]
			public CodeGen ();

			[CCode (cname = "lto_codegen_add_module")]
			public bool add_module (Module mod);
			[CCode (cname = "lto_codegen_add_must_preserve_symbol")]
			public void add_must_preserve_symbol (string symbol);
			[CCode (cname = "lto_codegen_compile")]
			public unowned uint8[] compile ();
			[CCode (cname = "lto_codegen_debug_options")]
			public void debug_options (string p2);
			[CCode(cname = "lto_codegen_set_assembler_args")]
			public void set_assembler_args(string[] args);
			[CCode (cname = "lto_codegen_set_assembler_path")]
			public void set_assembler_path (string path);
			[CCode (cname = "lto_codegen_set_debug_model")]
			public bool set_debug_model (DebugModel p2);
			[CCode (cname = "lto_codegen_set_gcc_path")]
			public void set_gcc_path (string path);
			[CCode (cname = "lto_codegen_set_pic_model")]
			public bool set_pic_model (CodeGenModel p2);
			[CCode (cname = "lto_codegen_write_merged_modules")]
			public bool write_merged_modules (string path);
			/**
			 * Generates code for all added modules into one native object file.
			 *
			 * @param name The name of the file is written to name.
			 * @return true on error.
			 */
			[CCode(cname = "lto_codegen_compile_to_file")]
			public bool compile_to_file(out unowned string name);
		}

		[Compact]
		[CCode (cname = "lto_module_t", free_function="lto_module_dispose", has_type_id = false)]
		public class Module {
			[CCode (cname = "lto_module_create")]
			public Module (string path);
			[CCode (cname = "lto_module_create_from_memory")]
			public Module.from_memory (void* mem, size_t length);
			[CCode(cname = "lto_module_create_from_fd")]
			public static Module? create_from_fd(int fd, string path, size_t file_size);
			[CCode(cname = "lto_module_create_from_fd_at_offset")]
			public static Module? create_from_fd_at_offset(int fd, string path, size_t file_size, size_t map_size, Posix.off_t offset);

			public uint symbol_count { [CCode (cname = "lto_module_get_num_symbols")] get; }
			[CCode (cname = "lto_module_get_symbol_attribute")]
			public SymbolAttributes get_symbol_attribute (uint index);
			[CCode (cname = "lto_module_get_symbol_name")]
			public string get_symbol_name (uint index);
			public string target_triple { [CCode (cname = "lto_module_get_target_triple")] get; }

			[CCode (cname = "lto_module_is_object_file")]
			public static bool is_object_file (string path);
			[CCode (cname = "lto_module_is_object_file_for_target")]
			public static bool is_object_file_for_target (string path, string target_triple_prefix);
			[CCode (cname = "lto_module_is_object_file_in_memory")]
			public static bool is_object_file_in_memory (void* mem, size_t length);
			[CCode (cname = "lto_module_is_object_file_in_memory_for_target")]
			public static bool is_object_file_in_memory_for_target (void* mem, size_t length, string target_triple_prefix);
			[CCode(cname = "LLVMGetTypeByName")]
			public Ty get_type(string name);
			[CCode(cname = "LLVMGetNamedMetadataNumOperands")]
			public uint get_named_metadata_operand_count(string name);
			[CCode(cname = "LLVMGetNamedMetadataOperands")]
			public void get_named_metadata_operand(string name, out Value dest);
		}

		[CCode (cname = "lto_get_error_message")]
		public unowned string? get_error_message ();
		[CCode (cname = "lto_get_version")]
		public unowned string get_version ();

		[CCode (cname = "lto_codegen_model", cprefix = "LTO_CODEGEN_PIC_MODEL_", has_type_id = "0")]
		public enum CodeGenModel {
			STATIC,
			DYNAMIC,
			DYNAMIC_NO_PIC
		}
		[CCode (cname = "lto_debug_model", cprefix = "LTO_DEBUG_MODEL_", has_type_id = "0")]
		public enum DebugModel {
			NONE,
			DWARF
		}
		[CCode (cname = "lto_symbol_attributes", cprefix = "LTO_SYMBOL_", has_type_id = "0")]
		public enum SymbolAttributes {
			ALIGNMENT_MASK,
			PERMISSIONS_MASK,
			PERMISSIONS_CODE,
			PERMISSIONS_DATA,
			PERMISSIONS_RODATA,
			DEFINITION_MASK,
			DEFINITION_REGULAR,
			DEFINITION_TENTATIVE,
			DEFINITION_WEAK,
			DEFINITION_UNDEFINED,
			DEFINITION_WEAKUNDEF,
			SCOPE_MASK,
			SCOPE_INTERNAL,
			SCOPE_HIDDEN,
			SCOPE_PROTECTED,
			SCOPE_DEFAULT
		}
		public const int API_VERSION;
	}
}
