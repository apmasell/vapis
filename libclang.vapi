[CCode(cheader_filename = "clang-c/Index.h")]
/**
 * Interface to Clang
 *
 * The Interface to Clang provides a relatively small API that exposes
 * facilities for parsing source code into an abstract syntax tree (AST),
 * loading already-parsed ASTs, traversing the AST, associating physical source
 * locations with elements within the AST, and other facilities that support
 * Clang-based development tools.
 *
 * This interface to Clang will never provide all of the information
 * representation stored in Clang's C++ AST, nor should it: the intent is to
 * maintain an API that is relatively stable from one release to the next,
 * providing only the basic functionality needed to support development tools.
 */
namespace Clang {
	/**
	 * Represents the C++ access control level to a base class for a
	 * cursor with kind {@link CursorKind.CXX_BASE_SPECIFIER}.
	 */
	[CCode(cname = "CX_CXXAccessSpecifier")]
	public enum AccessSpecifier {
		[CCode(cname = "CX_CXXInvalidAccessSpecifier")]
		INVALID,
		[CCode(cname = "CX_CXXPublic")]
		PUBLIC,
		[CCode(cname = "CX_CXXProtected")]
		PROTECTED,
		[CCode(cname = "CX_CXXPrivate")]
		PRIVATE
	}
	/**
	 * Describes the availability of a particular entity, which indicates whether
	 * the use of this entity will result in a warning or error due to it being
	 * deprecated or unavailable.
	 */
	[CCode(cname = "enum CXAvailabilityKind")]
	public enum Availability {
		/**
		 * The entity is available.
		 */
		[CCode(cname = "CXAvailability_Available")]
		AVAILABLE,
		/**
		 * The entity is available, but has been deprecated (and its use is not
		 * recommended).
		 */
		[CCode(cname = "CXAvailability_Deprecated")]
		DEPRECATED,
		/**
		 * The entity is not available; any use of it will be an error.
		 */
		[CCode(cname = "CXAvailability_NotAvailable")]
		NOT_AVAILABLE,
		/**
		 * The entity is available, but not accessible; any use of it will be an
		 * error.
		 */
		[CCode(cname = "CXAvailability_NotAccessible")]
		NOT_ACCESSIBLE
	}
	/**
	 * Describes how the traversal of the children of a particular cursor should
	 * proceed after visiting a particular child cursor.
	 */
	[CCode(cname = "enum CXChildVisitResult")]
	public enum ChildVisitResult {
		/**
		 * Terminates the cursor traversal.
		 */
		[CCode(cname = "CXChildVisit_Break")]
		BREAK,
		/**
		 * Continues the cursor traversal with the next sibling of the cursor just
		 * visited, without visiting its children.
		 */
		[CCode(cname = "CXChildVisit_Continue")]
		CONTINUE,
		/**
		 * Recursively traverse the children of this cursor, using the same
		 * visitor.
		 */
		[CCode(cname = "CXChildVisit_Recurse")]
		RECURSE
	}
	/**
	 * Describes the kind of entity that a cursor refers to.
	 */
	[CCode(cname = "enum CXCursorKind")]
	public enum CursorKind {
		/**
		 * A declaration whose specific kind is not exposed via this
		 * interface.
		 *
		 * Unexposed declarations have the same operations as any other kind
		 * of declaration; one can extract their location information,
		 * spelling, find their definitions, etc. However, the specific kind
		 * of the declaration is not reported.
		 */
		[CCode(cname = "CXCursor_UnexposedDecl")]
		UNEXPOSED_DECL,
		/**
		 * A C or C++ struct.
		 */
		[CCode(cname = "CXCursor_StructDecl")]
		STRUCT_DECL,
		/**
		 * A C or C++ union.
		 */
		[CCode(cname = "CXCursor_UnionDecl")]
		UNION_DECL,
		/**
		 * A C++ class.
		 */
		[CCode(cname = "CXCursor_ClassDecl")]
		CLASS_DECL,
		/**
		 * An enumeration.
		 */
		[CCode(cname = "CXCursor_EnumDecl")]
		ENUM_DECL,
		/**
		 * A field (in C) or non-static data member (in C++) in a
		 * struct, union, or C++ class.
		 */
		[CCode(cname = "CXCursor_FieldDecl")]
		FIELD_DECL,
		/**
		 * An enumerator constant.
		 */
		[CCode(cname = "CXCursor_EnumConstantDecl")]
		ENUM_CONSTANT_DECL,
		/**
		 * A function.
		 */
		[CCode(cname = "CXCursor_FunctionDecl")]
		FUNCTION_DECL,
		/**
		 * A variable.
		 */
		[CCode(cname = "CXCursor_VarDecl")]
		VAR_DECL,
		/**
		 * A function or method parameter.
		 */
		[CCode(cname = "CXCursor_ParmDecl")]
		PARM_DECL,
		/**
		 * An Objective-C @interface.
		 */
		[CCode(cname = "CXCursor_ObjCInterfaceDecl")]
		OBJC_INTERFACE_DECL,
		/**
		 * An Objective-C @interface for a category.
		 */
		[CCode(cname = "CXCursor_ObjCCategoryDecl")]
		OBJC_CATEGORY_DECL,
		/**
		 * An Objective-C @protocol declaration.
		 */
		[CCode(cname = "CXCursor_ObjCProtocolDecl")]
		OBJC_PROTOCOL_DECL,
		/**
		 * An Objective-C @property declaration.
		 */
		[CCode(cname = "CXCursor_ObjCPropertyDecl")]
		OBJC_PROPERTY_DECL,
		/**
		 * An Objective-C instance variable.
		 */
		[CCode(cname = "CXCursor_ObjCIvarDecl")]
		OBJC_IVAR_DECL,
		/**
		 * An Objective-C instance method.
		 */
		[CCode(cname = "CXCursor_ObjCInstanceMethodDecl")]
		OBJC_INSTANCE_METHOD_DECL,
		/**
		 * An Objective-C class method.
		 */
		[CCode(cname = "CXCursor_ObjCClassMethodDecl")]
		OBJC_CLASS_METHOD_DECL,
		/**
		 * An Objective-C @implementation.
		 */
		[CCode(cname = "CXCursor_ObjCImplementationDecl")]
		OBJC_IMPLEMENTATION_DECL,
		/**
		 * An Objective-C @implementation for a category.
		 */
		[CCode(cname = "CXCursor_ObjCCategoryImplDecl")]
		OBJC_CATEGORY_IMPL_DECL,
		/**
		 * A typedef
		 */
		[CCode(cname = "CXCursor_TypedefDecl")]
		TYPEDEF_DECL,
		/**
		 * A C++ class method.
		 */
		[CCode(cname = "CXCursor_CXXMethod")]
		CXX_METHOD,
		/**
		 * A C++ namespace.
		 */
		[CCode(cname = "CXCursor_Namespace")]
		NAMESPACE,
		/**
		 * A linkage specification, e.g. 'extern "C"'.
		 */
		[CCode(cname = "CXCursor_LinkageSpec")]
		LINKAGESPEC,
		/**
		 * A C++ constructor.
		 */
		[CCode(cname = "CXCursor_Constructor")]
		CONSTRUCTOR,
		/**
		 * A C++ destructor.
		 */
		[CCode(cname = "CXCursor_Destructor")]
		DESTRUCTOR,
		/**
		 * A C++ conversion function.
		 */
		[CCode(cname = "CXCursor_ConversionFunction")]
		CONVERSION_FUNCTION,
		/**
		 * A C++ template type parameter.
		 */
		[CCode(cname = "CXCursor_TemplateTypeParameter")]
		TEMPLATE_TYPE_PARAMETER,
		/**
		 * A C++ non-type template parameter.
		 */
		[CCode(cname = "CXCursor_NonTypeTemplateParameter")]
		NON_TYPE_TEMPLATE_PARAMETER,
		/**
		 * A C++ template template parameter.
		 */
		[CCode(cname = "CXCursor_TemplateTemplateParameter")]
		TEMPLATE_TEMPLATE_PARAMETER,
		/**
		 * A C++ function template.
		 */
		[CCode(cname = "CXCursor_FunctionTemplate")]
		FUNCTION_TEMPLATE,
		/**
		 * A C++ class template.
		 */
		[CCode(cname = "CXCursor_ClassTemplate")]
		CLASS_TEMPLATE,
		/**
		 * A C++ class template partial specialization.
		 */
		[CCode(cname = "CXCursor_ClassTemplatePartialSpecialization")]
		CLASS_TEMPLATE_PARTIAL_SPECIALIZATION,
		/**
		 * A C++ namespace alias declaration.
		 */
		[CCode(cname = "CXCursor_NamespaceAlias")]
		NAMESPACE_ALIAS,
		/**
		 * A C++ using directive.
		 */
		[CCode(cname = "CXCursor_UsingDirective")]
		USING_DIRECTIVE,
		/**
		 * A C++ using declaration.
		 */
		[CCode(cname = "CXCursor_UsingDeclaration")]
		USING_DECLARATION,
		/**
		 * A C++ alias declaration
		 */
		[CCode(cname = "CXCursor_TypeAliasDecl")]
		TYPE_ALIAS_DECL,
		/**
		 * An Objective-C @synthesize definition.
		 */
		[CCode(cname = "CXCursor_ObjCSynthesizeDecl")]
		OBJC_SYNTHESIZE_DECL,
		/**
		 * An Objective-C @dynamic definition.
		 */
		[CCode(cname = "CXCursor_ObjCDynamicDecl")]
		OBJC_DYNAMIC_DECL,
		/**
		 * An access specifier.
		 */
		[CCode(cname = "CXCursor_CXXAccessSpecifier")]
		CXX_ACCESS_SPECIFIER,
		[CCode(cname = "CXCursor_FirstDecl")]
		FIRST_DECL,
		[CCode(cname = "CXCursor_LastDecl")]
		LAST_DECL,
		[CCode(cname = "CXCursor_FirstRef")]
		FIRST_REF,
		[CCode(cname = "CXCursor_ObjCSuperClassRef")]
		OBJC_SUPER_CLASS_REF,
		[CCode(cname = "CXCursor_ObjCProtocolRef")]
		OBJC_PROTOCOL_REF,
		[CCode(cname = "CXCursor_ObjCClassRef")]
		OBJC_CLASS_REF,
		/**
		 * A reference to a type declaration.
		 *
		 * A type reference occurs anywhere where a type is named but not
		 * declared.
		 */
		[CCode(cname = "CXCursor_TypeRef")]
		TYPE_REF,
		[CCode(cname = "CXCursor_CXXBaseSpecifier")]
		CXX_BASE_SPECIFIER,
		/**
		 * A reference to a class template, function template, template template
		 * parameter, or class template partial specialization.
		 */
		[CCode(cname = "CXCursor_TemplateRef")]
		TEMPLATE_REF,
		/**
		 * A reference to a namespace or namespace alias.
		 */
		[CCode(cname = "CXCursor_NamespaceRef")]
		NAMESPACE_REF,
		/**
		 * A reference to a member of a struct, union, or class that occurs in some
		 * non-expression context, e.g., a designated initializer.
		 */
		[CCode(cname = "CXCursor_MemberRef")]
		MEMBER_REF,
		/**
		 * A reference to a labeled statement.
		 */
		[CCode(cname = "CXCursor_LabelRef")]
		LABEL_REF,
		/**
		 * A reference to a set of overloaded functions or function templates that
		 * has not yet been resolved to a specific function or function template.
		 *
		 * An overloaded declaration reference cursor occurs in C++ templates where
		 * a dependent name refers to a function.
		 *
		 * The functions {@link Cursor.overloaded_count} and
		 * {@link Cursor.get_overloaded_decl} can be used to retrieve the
		 * definitions referenced by this cursor.
		 */
		[CCode(cname = "CXCursor_OverloadedDeclRef")]
		OVERLOADED_DECL_REF,
		[CCode(cname = "CXCursor_LastRef")]
		LAST_REF,
		[CCode(cname = "CXCursor_FirstInvalid")]
		FIRST_INVALID,
		[CCode(cname = "CXCursor_InvalidFile")]
		INVALID_FILE,
		[CCode(cname = "CXCursor_NoDeclFound")]
		NO_DECL_FOUND,
		[CCode(cname = "CXCursor_NotImplemented")]
		NOT_IMPLEMENTED,
		[CCode(cname = "CXCursor_InvalidCode")]
		INVALID_CODE,
		[CCode(cname = "CXCursor_LastInvalid")]
		LAST_INVALID,
		[CCode(cname = "CXCursor_FirstExpr")]
		FIRST_EXPR,
		/**
		 * An expression whose specific kind is not exposed via this interface.
		 *
		 * Unexposed expressions have the same operations as any other kind of
		 * expression; one can extract their location information, spelling,
		 * children, etc. However, the specific kind of the expression is not
		 * reported.
		 */
		[CCode(cname = "CXCursor_UnexposedExpr")]
		UNEXPOSED_EXPR,
		/**
		 * An expression that refers to some value declaration, such as a function,
		 * varible, or enumerator.
		 */
		[CCode(cname = "CXCursor_DeclRefExpr")]
		DECL_REF_EXPR,
		/**
		 * An expression that refers to a member of a struct, union, class,
		 * Objective-C class, etc.
		 */
		[CCode(cname = "CXCursor_MemberRefExpr")]
		MEMBER_REF_EXPR,
		/**
		 * An expression that calls a function.
		 */
		[CCode(cname = "CXCursor_CallExpr")]
		CALL_EXPR,
		/**
		 * An expression that sends a message to an Objective-C object or class.
		 */
		[CCode(cname = "CXCursor_ObjCMessageExpr")]
		OBJC_MESSAGE_EXPR,
		/**
		 * An expression that represents a block literal.
		 */
		[CCode(cname = "CXCursor_BlockExpr")]
		BLOCK_EXPR,
		/**
		 * An integer literal.
		 */
		[CCode(cname = "CXCursor_IntegerLiteral")]
		INTEGER_LITERAL,
		/**
		 * A floating point number literal.
		 */
		[CCode(cname = "CXCursor_FloatingLiteral")]
		FLOATING_LITERAL,
		/**
		 * An imaginary number literal.
		 */
		[CCode(cname = "CXCursor_ImaginaryLiteral")]
		IMAGINARY_LITERAL,
		/**
		 * A string literal.
		 */
		[CCode(cname = "CXCursor_StringLiteral")]
		STRING_LITERAL,
		/**
		 * A character literal.
		 */
		[CCode(cname = "CXCursor_CharacterLiteral")]
		CHARACTER_LITERAL,
		/**
		 * A parenthesized expression, e.g. "(1)".
		 *
		 * This AST node is only formed if full location information is requested.
		 */
		[CCode(cname = "CXCursor_ParenExpr")]
		PAREN_EXPR,
		/**
		 * This represents the unary-expression's (except sizeof and alignof).
		 */
		[CCode(cname = "CXCursor_UnaryOperator")]
		UNARY_OPERATOR,
		/**
		 * [C99 6.5.2.1] Array Subscripting.
		 */
		[CCode(cname = "CXCursor_ArraySubscriptExpr")]
		ARRAY_SUBSCRIPT_EXPR,
		/**
		 * A builtin binary operation expression such as "x + y" or "x <= y".
		 */
		[CCode(cname = "CXCursor_BinaryOperator")]
		BINARY_OPERATOR,
		/**
		 * Compound assignment such as "+=".
		 */
		[CCode(cname = "CXCursor_CompoundAssignOperator")]
		COMPOUND_ASSIGN_OPERATOR,
		/**
		 * The ?: ternary operator.
		 */
		[CCode(cname = "CXCursor_ConditionalOperator")]
		CONDITIONAL_OPERATOR,
		/**
		 * An explicit cast in C (C99 6.5.4) or a C-style cast in C++ (C++
		 * [expr.cast]), which uses the syntax (Type)expr.
		 */
		[CCode(cname = "CXCursor_CStyleCastExpr")]
		C_STYLE_CAST_EXPR,
		/**
		 * [C99 6.5.2.5]
		 */
		[CCode(cname = "CXCursor_CompoundLiteralExpr")]
		COMPOUND_LITERAL_EXPR,
		/**
		 * Describes an C or C++ initializer list.
		 */
		[CCode(cname = "CXCursor_InitListExpr")]
		INIT_LIST_EXPR,
		/**
		 * The GNU address of label extension, representing &&label.
		 */
		[CCode(cname = "CXCursor_AddrLabelExpr")]
		ADDR_LABEL_EXPR,
		/**
		 * This is the GNU Statement Expression extension: ({int X=4; X;})
		 */
		[CCode(cname = "CXCursor_StmtExpr")]
		STMT_EXPR,
		/**
		 * Represents a C1X generic selection.
		 */
		[CCode(cname = "CXCursor_GenericSelectionExpr")]
		GENERIC_SELECTION_EXPR,
	 /**
		 * Implements the GNU \_\_null extension, which is a name for a null
		 * pointer constant that has integral type (e.g., int or long) and is the
		 * same size and alignment as a pointer.
		 *
		 * The extension is typically only used by system headers, which define
		 * NULL in C++ rather than using 0 (which is an integer that may not match
		 * the size of a pointer).
		 */
		[CCode(cname = "CXCursor_GNUNullExpr")]
		GNU_NULL_EXPR,
		/**
		 * C++'s static_cast<> expression.
		 */
		[CCode(cname = "CXCursor_CXXStaticCastExpr")]
		CXX_STATIC_CAST_EXPR,
		/**
		 * C++'s dynamic_cast<> expression.
		 */
		[CCode(cname = "CXCursor_CXXDynamicCastExpr")]
		CXX_DYNAMIC_CAST_EXPR,
		/**
		 * C++'s reinterpret_cast<> expression.
		 */
		[CCode(cname = "CXCursor_CXXReinterpretCastExpr")]
		CXX_REINTERPRET_CAST_EXPR,
		/**
		 * C++'s const_cast<> expression.
		 */
		[CCode(cname = "CXCursor_CXXConstCastExpr")]
		CXX_CONST_CAST_EXPR,
		/**
		 * Represents an explicit C++ type conversion that uses "functional" notion
		 * (C++ [expr.type.conv]).
		 */
		[CCode(cname = "CXCursor_CXXFunctionalCastExpr")]
		CXX_FUNCTIONAL_CAST_EXPR,
		/**
		 * A C++ typeid expression (C++ [expr.typeid]).
		 */
		[CCode(cname = "CXCursor_CXXTypeidExpr")]
		CXX_TYPEID_EXPR,
		/**
		 * [C++ 2.13.5] C++ Boolean Literal.
		 */
		[CCode(cname = "CXCursor_CXXBoolLiteralExpr")]
		CXX_BOOL_LITERAL_EXPR,
		/**
		 * [C++0x 2.14.7] C++ Pointer Literal.
		 */
		[CCode(cname = "CXCursor_CXXNullPtrLiteralExpr")]
		CXX_NULL_PTR_LITERAL_EXPR,
		/**
		 * Represents the "this" expression in C++
		 */
		[CCode(cname = "CXCursor_CXXThisExpr")]
		CXX_THIS_EXPR,
		/**
		 * [C++ 15] C++ Throw Expression.
		 *
		 * This handles 'throw' and 'throw' assignment-expression. When
		 * assignment-expression isn't present, Op will be null.
		 */
		[CCode(cname = "CXCursor_CXXThrowExpr")]
		CXX_THROW_EXPR,
		/**
		 * A new expression for memory allocation and constructor calls, e.g: "new
		 * CXXNewExpr(foo)".
		 */
		[CCode(cname = "CXCursor_CXXNewExpr")]
		CXX_NEW_EXPR,
		/**
		 * A delete expression for memory deallocation and destructor calls, e.g.
		 * "delete[] pArray".
		 */
		[CCode(cname = "CXCursor_CXXDeleteExpr")]
		CXX_DELETE_EXPR,
		/**
		 * A unary expression.
		 */
		[CCode(cname = "CXCursor_UnaryExpr")]
		UNARY_EXPR,
		/**
		 * ObjCStringLiteral, used for Objective-C string literals i.e. "foo".
		 */
		[CCode(cname = "CXCursor_ObjCStringLiteral")]
		OBJC_STRING_LITERAL,
		/**
		 * ObjCEncodeExpr, used for in Objective-C.
		 */
		[CCode(cname = "CXCursor_ObjCEncodeExpr")]
		OBJC_ENCODE_EXPR,
		/**
		 * ObjCSelectorExpr used for in Objective-C.
		 */
		[CCode(cname = "CXCursor_ObjCSelectorExpr")]
		OBJC_SELECTOR_EXPR,
		/**
		 * Objective-C's protocol expression.
		 */
		[CCode(cname = "CXCursor_ObjCProtocolExpr")]
		OBJC_PROTOCOL_EXPR,
		 /**
		 * An Objective-C "bridged" cast expression, which casts between
		 * Objective-C pointers and C pointers, transferring ownership in the
		 * process.
		 */
		[CCode(cname = "CXCursor_ObjCBridgedCastExpr")]
		OBJC_BRIDGED_CAST_EXPR,
		/**
		 * Represents a C++0x pack expansion that produces a sequence of expressions.
		 *
		 * A pack expansion expression contains a pattern (which itself is an
		 * expression) followed by an ellipsis.
		 */
		[CCode(cname = "CXCursor_PackExpansionExpr")]
		PACK_EXPANSION_EXPR,
		/**
		 * Represents an expression that computes the length of a parameter pack.
		 */
		[CCode(cname = "CXCursor_SizeOfPackExpr")]
		SIZE_OF_PACK_EXPR,
		[CCode(cname = "CXCursor_LastExpr")]
		LAST_EXPR,
		[CCode(cname = "CXCursor_FirstStmt")]
		FIRST_STMT,
		/**
		 * A statement whose specific kind is not exposed via this interface.
		 *
		 * Unexposed statements have the same operations as any other kind of
		 * statement; one can extract their location information, spelling,
		 * children, etc. However, the specific kind of the statement is not
		 * reported.
		 */
		[CCode(cname = "CXCursor_UnexposedStmt")]
		UNEXPOSED_STMT,
		/**
		 * A labelled statement in a function.
		 */
		[CCode(cname = "CXCursor_LabelStmt")]
		LABEL_STMT,
		/**
		 * A group of statements like { stmt stmt }.
		 *
		 * This cursor kind is used to describe compound statements, e.g. function
		 * bodies.
		 */
		[CCode(cname = "CXCursor_CompoundStmt")]
		COMPOUND_STMT,
		/**
		 * A case statment.
		 */
		[CCode(cname = "CXCursor_CaseStmt")]
		CASE_STMT,
		/**
		 * A default statement.
		 */
		[CCode(cname = "CXCursor_DefaultStmt")]
		DEFAULT_STMT,
		/**
		 * An if statement
		 */
		[CCode(cname = "CXCursor_IfStmt")]
		IF_STMT,
		/**
		 * A switch statement.
		 */
		[CCode(cname = "CXCursor_SwitchStmt")]
		SWITCH_STMT,
		/**
		 * A while statement.
		 */
		[CCode(cname = "CXCursor_WhileStmt")]
		WHILE_STMT,
		/**
		 * A do statement.
		 */
		[CCode(cname = "CXCursor_DoStmt")]
		DO_STMT,
		/**
		 * A for statement.
		 */
		[CCode(cname = "CXCursor_ForStmt")]
		FOR_STMT,
		/**
		 * A goto statement.
		 */
		[CCode(cname = "CXCursor_GotoStmt")]
		GOTO_STMT,
		/**
		 * An indirect goto statement.
		 */
		[CCode(cname = "CXCursor_IndirectGotoStmt")]
		INDIRECT_GOTO_STMT,
		/**
		 * A continue statement.
		 */
		[CCode(cname = "CXCursor_ContinueStmt")]
		CONTINUE_STMT,
		/**
		 * A break statement.
		 */
		[CCode(cname = "CXCursor_BreakStmt")]
		BREAK_STMT,
		/**
		 * A return statement.
		 */
		[CCode(cname = "CXCursor_ReturnStmt")]
		RETURN_STMT,
		/**
		 * A GNU inline assembly statement extension.
		 */
		[CCode(cname = "CXCursor_AsmStmt")]
		ASM_STMT,
		/**
		 * Objective-C's overall @try-@catc-@finall statement.
		 */
		[CCode(cname = "CXCursor_ObjCAtTryStmt")]
		OBJC_AT_TRY_STMT,
		/**
		 * Objective-C's @catch statement.
		 */
		[CCode(cname = "CXCursor_ObjCAtCatchStmt")]
		OBJC_AT_CATCH_STMT,
		/**
		 * Objective-C's @finally statement.
		 */
		[CCode(cname = "CXCursor_ObjCAtFinallyStmt")]
		OBJC_AT_FINALLY_STMT,
		/**
		 * Objective-C's @throw statement.
		 */
		[CCode(cname = "CXCursor_ObjCAtThrowStmt")]
		OBJC_AT_THROW_STMT,
		/**
		 * Objective-C's @synchronized statement.
		 */
		[CCode(cname = "CXCursor_ObjCAtSynchronizedStmt")]
		OBJC_AT_SYNCHRONIZED_STMT,
		/**
		 * Objective-C's autorelease pool statement.
		 */
		[CCode(cname = "CXCursor_ObjCAutoreleasePoolStmt")]
		OBJC_AUTORELEASE_POOL_STMT,
		/**
		 * Objective-C's collection statement.
		 */
		[CCode(cname = "CXCursor_ObjCForCollectionStmt")]
		OBJC_FOR_COLLECTION_STMT,
		/**
		 * C++'s catch statement.
		 */
		[CCode(cname = "CXCursor_CXXCatchStmt")]
		CXX_CATCH_STMT,
		/**
		 * C++'s try statement.
		 */
		[CCode(cname = "CXCursor_CXXTryStmt")]
		CXX_TRY_STMT,
		/**
		 * C++'s for (* : *) statement.
		 */
		[CCode(cname = "CXCursor_CXXForRangeStmt")]
		CXX_FOR_RANGE_STMT,
		/**
		 * Windows Structured Exception Handling's try statement.
		 */
		[CCode(cname = "CXCursor_SEHTryStmt")]
		SEH_TRY_STMT,
		/**
		 * Windows Structured Exception Handling's except statement.
		 */
		[CCode(cname = "CXCursor_SEHExceptStmt")]
		SEH_EXCEPT_STMT,
		/**
		 * Windows Structured Exception Handling's finally statement.
		 */
		[CCode(cname = "CXCursor_SEHFinallyStmt")]
		SEH_FINALLY_STMT,
		/**
		 * The null satement ";": C99 6.8.3p3.
		 *
		 * This cursor kind is used to describe the null statement.
		 */
		[CCode(cname = "CXCursor_NullStmt")]
		NULL_STMT,
		/**
		 * Adaptor class for mixing declarations with statements and expressions.
		 */
		[CCode(cname = "CXCursor_DeclStmt")]
		DECL_STMT,
		[CCode(cname = "CXCursor_LastStmt")]
		LAST_STMT,
		/**
		 * Cursor that represents the translation unit itself.
		 *
		 * The translation unit cursor exists primarily to act as the root
		 * cursor for traversing the contents of a translation unit.
		 */
		[CCode(cname = "CXCursor_TranslationUnit")]
		TRANSLATION_UNIT,
		[CCode(cname = "CXCursor_FirstAttr")]
		FIRST_ATTR,
		/**
		 * An attribute whose specific kind is not exposed via this interface.
		 */
		[CCode(cname = "CXCursor_UnexposedAttr")]
		UNEXPOSED_ATTR,
		[CCode(cname = "CXCursor_IBActionAttr")]
		IBACTIONATTR,
		[CCode(cname = "CXCursor_IBOutletAttr")]
		IB_OUTLET_ATTR,
		[CCode(cname = "CXCursor_IBOutletCollectionAttr")]
		IB_OUTLET_COLLECTION_ATTR,
		[CCode(cname = "CXCursor_CXXFinalAttr")]
		CXX_FINAL_ATTR,
		[CCode(cname = "CXCursor_CXXOverrideAttr")]
		CXX_OVERRIDE_ATTR,
		[CCode(cname = "CXCursor_AnnotateAttr")]
		ANNOTATE_ATTR,
		[CCode(cname = "CXCursor_LastAttr")]
		LAST_ATTR,
		[CCode(cname = "CXCursor_PreprocessingDirective")]
		PREPROCESSING_DIRECTIVE,
		[CCode(cname = "CXCursor_MacroDefinition")]
		MACRO_DEFINITION,
		[CCode(cname = "CXCursor_MacroExpansion")]
		MACRO_EXPANSION,
		[CCode(cname = "CXCursor_MacroInstantiation")]
		MACRO_INSTANTIATION,
		[CCode(cname = "CXCursor_InclusionDirective")]
		INCLUSION_DIRECTIVE,
		[CCode(cname = "CXCursor_FirstPreprocessing")]
		FIRST_PREPROCESSING,
		[CCode(cname = "CXCursor_LastPreprocessing")]
		LAST_PREPROCESSING;
		/**
		 * Determine whether the given cursor kind represents an attribute.
		 */
		 [CCode(cname = "clang_isAttribute")]
		 public bool is_attribute();
		/**
		 * Determine whether the given cursor kind represents a declaration.
		 */
		[CCode(cname = "clang_isDeclaration")]
		public bool is_declaration();
		/**
		 * Determine whether the given cursor kind represents an expression.
		 */
		[CCode(cname = "clang_isExpression")]
		public bool is_expression();
		/**
		 * Determine whether the given cursor kind represents an invalid
		 * cursor.
		 */
		[CCode(cname = "clang_isInvalid")]
		public bool is_invalid();
		/**
		 * Determine whether the given cursor represents a preprocessing
		 * element, such as a preprocessor directive or macro instantiation.
		 */
		[CCode(cname = "clang_isPreprocessing")]
		public bool is_preprocessing();
		/**
		 * Determine whether the given cursor kind represents a simple reference.
		 *
		 * Note that other kinds of cursors (such as expressions) can also refer to
		 * other cursors. Use {@link Cursor.get_referenced} to determine
		 * whether a particular cursor refers to another entity.
		 */
		[CCode(cname = "clang_isReference")]
		public bool is_reference();
		/**
		 * Determine whether the given cursor kind represents a statement.
		 */
		[CCode(cname = "clang_isStatement")]
		public bool is_statement();
		/**
		 * Determine whether the given cursor kind represents a translation
		 * unit.
		 */
		[CCode(cname = "clang_isTranslationUnit")]
		public bool is_translation_unit();
		/**
		 * Determine whether the given cursor represents a currently
		 * unexposed piece of the AST (e.g., {@link CursorKind.UNEXPOSED_STMT}).
		 */
		[CCode(cname = "clang_isUnexposed")]
		public bool is_unexposed();
		[CCode(cname = "getCursorKindSpelling")]
		public String get_spelling();
	}
	/**
	 * Describe the "language" of the entity referred to by a cursor.
	 */
	[CCode(cname = "enum CXLanguageKind")]
	public enum Language {
		[CCode(cname = "CXLanguage_Invalid")]
		INVALID,
		[CCode(cname = "CXLanguage_C")]
		C,
		[CCode(cname = "CXLanguage_ObjC")]
		OBJ_C,
		[CCode(cname = "CXLanguage_CPlusPlus")]
		C_PLUS_PLUS
	}
	/**
	 * Describe the linkage of the entity referred to by a cursor.
	 */
	[CCode(cname = "enum CXLinkageKind")]
	public enum Linkage {
		/**
		 * This value indicates that no linkage information is available.
		 */
		[CCode(cname = "CXLinkage_Invalid")]
		INVALID,
		/**
		 * This is the linkage for variables, parameters, and so on that have
		 * automatic storage. This covers normal (non-extern) local variables.
		 */
		[CCode(cname = "CXLinkage_NoLinkage")]
		NO_LINKAGE,
		/**
		 * This is the linkage for static variables and static functions.
		 */
		[CCode(cname = "CXLinkage_Internal")]
		INTERNAL,
		/**
		 * This is the linkage for entities with external linkage that live in C++
		 * anonymous namespaces.
		 */
		[CCode(cname = "CXLinkage_UniqueExternal")]
		UNIQUE_EXTERNAL,
		/**
		 * This is the linkage for entities with true, external linkage.
		 */
		[CCode(cname = "CXLinkage_External")]
		EXTERNAL
	}
	[CCode(cname = "enum CXNameRefFlags")]
	[Flags]
	public enum NameRef {
		/**
		 * Include the nested-name-specifier, e.g., Foo:: in x.Foo::y, in the
		 * range.
		 */
		[CCode(cname = "CXNameRange_WantQualifier")]
		WANT_QUALIFIER,
		/**
		 * Include the explicit template arguments, e.g. <int> in x.f<int>, in the
		 * range.
		 */
		[CCode(cname = "CXNameRange_WantTemplateArgs")]
		WANT_TEMPLATE_ARGS,
		/**
		 * If the name is non-contiguous, return the full spanning range.
		 *
		 * Non-contiguous names occur in Objective-C when a selector with two or more
		 * parameters is used, or in C++ when using an operator.
		 */
		[CCode(cname = "CXNameRange_WantSinglePiece")]
		WANT_SINGLE_PIECE
	}
	/**
	 * Flags that control the reparsing of translation units.
	 */
	[CCode(cname = "CXReparse_Flags")]
	[Flags]
	public enum ReparseFlags {
		/**
		 * Used to indicate that no special reparsing options are needed.
		 */
		[CCode(cname = "CXReparse_None")]
		NONE
	}
	/**
	 * Categorizes how memory is being used by a translation unit.
	 */
	[CCode(cname = "enum CXTUResourceUsageKind")]
	public enum Resource {
		[CCode(cname = "CXTUResourceUsage_AST")]
		AST,
		[CCode(cname = "CXTUResourceUsage_Identifiers")]
		IDENTIFIERS,
		[CCode(cname = "CXTUResourceUsage_Selectors")]
		SELECTORS,
		[CCode(cname = "CXTUResourceUsage_GlobalCompletionResults")]
		GLOBAL_COMPLETION_RESULTS,
		[CCode(cname = "CXTUResourceUsage_SourceManagerContentCache")]
		SOURCE_MANAGER_CONTENT_CACHE,
		[CCode(cname = "CXTUResourceUsage_AST_SideTables")]
		AST_SIDE_TABLES,
		[CCode(cname = "CXTUResourceUsage_SourceManager_Membuffer_Malloc")]
		SOURCE_MANAGER_MEMBUFFER_MALLOC,
		[CCode(cname = "CXTUResourceUsage_SourceManager_Membuffer_MMap")]
		SOURCE_MANAGER_MEMBUFFER_MMAP,
		[CCode(cname = "CXTUResourceUsage_ExternalASTSource_Membuffer_Malloc")]
		EXTERNAL_AST_SOURCE_MEMBUFFER_MALLOC,
		[CCode(cname = "CXTUResourceUsage_ExternalASTSource_Membuffer_MMap")]
		EXTERNAL_AST_SOURCE_MEMBUFFER_MMAP,
		[CCode(cname = "CXTUResourceUsage_Preprocessor")]
		PREPROCESSOR,
		[CCode(cname = "CXTUResourceUsage_PreprocessingRecord")]
		PREPROCESSING_RECORD,
		[CCode(cname = "CXTUResourceUsage_SourceManager_DataStructures")]
		SOURCE_MANAGER_DATA_STRUCTURES,
		[CCode(cname = "CXTUResourceUsage_Preprocessor_HeaderSearch")]
		PREPROCESSOR_HEADER_SEARCH,
		[CCode(cname = "CXTUResourceUsage_MEMORY_IN_BYTES_BEGIN")]
		MEMORY_IN_BYTES_BEGIN,
		[CCode(cname = "CXTUResourceUsage_MEMORY_IN_BYTES_END")]
		MEMORY_IN_BYTES_END;
		/**
		 * The human-readable string that represents the name of the memory
		 * category.
		 */
		[CCode(cname = "clang_getTUResourceUsageName")]
		public unowned string to_string();
	}
	[CCode(cname = "enum CXSaveError")]
	public enum SaveError {
		/**
		 * Indicates that no error occurred while saving a translation unit.
		 */
		[CCode(cname = "CXSaveError_None")]
		NONE,
		/**
		 * Indicates that an unknown error occurred while attempting to save
		 * the file.
		 *
		 * This error typically indicates that file I/O failed when attempting to 
		 * write the file.
		 */
		[CCode(cname = "CXSaveError_Unknown")]
		UNKNOWN,
		/**
		 * Indicates that errors during translation prevented this attempt to save
		 * the translation unit.
		 *
		 * Errors that prevent the translation unit from being saved can be
		 * extracted using {@link TranslationUnit.diagnostics}.
		 */
		[CCode(cname = "CXSaveError_TranslationErrors")]
		TRANSLATION_ERRORS,
		/**
		 * Indicates that the translation unit to be saved was somehow invalid.
		 */
		[CCode(cname = "CXSaveError_InvalidTU")]
		INVALID_TU
	}
	/**
	 * Flags that control how translation units are saved.
	 *
	 * The enumerators in this enumeration type are meant to be bitwise
	 * ORed together to specify which options should be used when
	 * saving the translation unit.
	 */
	[CCode(cname = "CXSaveTranslationUnit_Flags")]
	[Flags]
	public enum SaveFlags {
		/**
		 * Used to indicate that no special saving options are needed.
		 */
		[CCode(cname = "CXSaveTranslationUnit_None")]
		NONE
	}
	/**
	 * Describes the severity of a particular diagnostic.
	 */
	[CCode(cname = "enum CXDiagnosticSeverity")]
	public enum Severity {
		/**
		 * A diagnostic that has been suppressed, e.g., by a command-line option.
		 */
		[CCode(cname = "CXDiagnostic_Ignored")]
		IGNORED,
		/**
		 * This diagnostic is a note that should be attached to the previous
		 * (non-note) diagnostic.
		 */
		[CCode(cname = "CXDiagnostic_Note")]
		NOTE,
		/**
		 * This diagnostic indicates suspicious code that may not be wrong.
		 */
		[CCode(cname = "CXDiagnostic_Warning")]
		WARNING,
		/**
		 * This diagnostic indicates that the code is ill-formed.
		 */
		[CCode(cname = "CXDiagnostic_Error")]
		ERROR,
		/**
		 * This diagnostic indicates that the code is ill-formed such that future
		 * parser recovery is unlikely to produce useful results.
		 */
		[CCode(cname = "CXDiagnostic_Fatal")]
		FATAL
	}
	/**
	 * Describes a kind of token.
	 */
	[CCode(cname = "CXTokenKind")]
	public enum TokenKind {
		/**
		 * A token that contains some kind of punctuation.
		 */
		[CCode(cname = "CXToken_Punctuation")]
		PUNCTUATION,
		/**
		 * A language keyword.
		 */
		[CCode(cname = "CXToken_Keyword")]
		KEYWORD,
		/**
		 * An identifier (that is not a keyword).
		 */
		[CCode(cname = "CXToken_Identifier")]
		IDENTIFIER,
		/**
		 * A numeric, string, or character literal.
		 */
		[CCode(cname = "CXToken_Literal")]
		LITERAL,
		/**
		 * A comment.
		 */
		[CCode(cname = "CXToken_Comment")]
		COMMENT
	}
	/**
	 * Describes the kind of type
	 */
	[CCode(cname = "CXTypeKind")]
	public enum TypeKind {
		/**
		 * Reprents an invalid type (e.g., where no type is available).
		 */
		[CCode(cname = "CXType_Invalid")]
		INVALID,
		/**
		 * A type whose specific kind is not exposed via this interface.
		 */
		[CCode(cname = "CXType_Unexposed")]
		UNEXPOSED,
		[CCode(cname = "CXType_Void")]
		VOID,
		[CCode(cname = "CXType_Bool")]
		BOOL,
		[CCode(cname = "CXType_Char")]
		CHAR,
		[CCode(cname = "CXType_UChar")]
		UCHAR,
		[CCode(cname = "CXType_Char16")]
		CHAR16,
		[CCode(cname = "CXType_Char32")]
		CHAR32,
		[CCode(cname = "CXType_UShort")]
		USHORT,
		[CCode(cname = "CXType_UInt")]
		UINT,
		[CCode(cname = "CXType_ULong")]
		ULONG,
		[CCode(cname = "CXType_ULongLong")]
		ULONG_LONG,
		[CCode(cname = "CXType_UInt128")]
		UINT128,
		[CCode(cname = "CXType_Char_S")]
		CHAR_S,
		[CCode(cname = "CXType_SChar")]
		SCHAR,
		[CCode(cname = "CXType_WChar")]
		WCHAR,
		[CCode(cname = "CXType_Short")]
		SHORT,
		[CCode(cname = "CXType_Int")]
		INT,
		[CCode(cname = "CXType_Long")]
		LONG,
		[CCode(cname = "CXType_LongLong")]
		LONG_LONG,
		[CCode(cname = "CXType_Int128")]
		INT128,
		[CCode(cname = "CXType_Float")]
		FLOAT,
		[CCode(cname = "CXType_Double")]
		DOUBLE,
		[CCode(cname = "CXType_LongDouble")]
		LONG_DOUBLE,
		[CCode(cname = "CXType_NullPtr")]
		NULL_PTR,
		[CCode(cname = "CXType_Overload")]
		OVERLOAD,
		[CCode(cname = "CXType_Dependent")]
		DEPENDENT,
		[CCode(cname = "CXType_ObjCId")]
		OBJC_ID,
		[CCode(cname = "CXType_ObjCClass")]
		OBJC_CLASS,
		[CCode(cname = "CXType_ObjCSel")]
		OBJC_SEL,
		[CCode(cname = "CXType_FirstBuiltin")]
		FIRST_BUILTIN,
		[CCode(cname = "CXType_LastBuiltin")]
		LAST_BUILTIN,
		[CCode(cname = "CXType_Complex")]
		COMPLEX,
		[CCode(cname = "CXType_Pointer")]
		POINTER,
		[CCode(cname = "CXType_BlockPointer")]
		BLOCK_POINTER,
		[CCode(cname = "CXType_LValueReference")]
		LVALUE_REFERENCE,
		[CCode(cname = "CXType_RValueReference")]
		RVALUE_REFERENCE,
		[CCode(cname = "CXType_Record")]
		RECORD,
		[CCode(cname = "CXType_Enum")]
		ENUM,
		[CCode(cname = "CXType_Typedef")]
		TYPEDEF,
		[CCode(cname = "CXType_ObjCInterface")]
		OBJC_INTERFACE,
		[CCode(cname = "CXType_ObjCObjectPointer")]
		OBJC_OBJECT_POINTER,
		[CCode(cname = "CXType_FunctionNoProto")]
		FUNCTION_NO_PROTO,
		[CCode(cname = "CXType_FunctionProto")]
		FUNCTION_PROTO,
		[CCode(cname = "CXType_ConstantArray")]
		CONSTANT_ARRAY;
		/**
		 * Retrieve the spelling of a given TypeKind.
		 */
		[CCode(cname = "clang_getTypeKindSpelling")]
		public String get_spelling();
	}
	[CCode(cname = "enum CXVisitorResult")]
	public enum VisitorResult {
		[CCode(cname = "CXVisit_Break")]
		BREAK,
		[CCode(cname = "CXVisit_Continue")]
		CONTINUE
	}
	/**
	 * A fast container representing a set of Cursors.
	 */
	[CCode(cname = "struct CXCursorSetImpl", free_function = "clang_disposeCXCursorSet")]
	[Compact]
	public class CursorSet {
		/**
		 * Creates an empty set.
		 */
		[CCode(cname = "clang_createCXCursorSet")]
		public CursorSet();
		/**
		 * Queries to see if it contains a specific cursor.
		 */
		[CCode(cname = "clang_CXCursorSet_contains")]
		public bool contains(Cursor cursor);
		/**
		 * Inserts a CXCursor into a CXCursorSet.
		 *
		 * @return false if the cursor was already in the set, and true otherwise.
		 */
		[CCode(cname = "clang_CXCursorSet_insert")]
		public bool insert(Cursor cursor);
	}
	/**
	 * A single diagnostic, containing the diagnostic's severity, location, text,
	 * source ranges, and fix-it hints.
	 */
	[CCode(cname = "void", free_function = "clang_disposeDiagnostic")]
	[Compact]
	public class Diagnostic {
		/**
		 * Options to control the display of diagnostics.
		 */
		[CCode(cname = "enum CXDiagnosticDisplayOptions")]
		[Flags]
		public enum Display {
			/**
			 * Display the source-location information where the diagnostic was located.
			 *
			 * When set, diagnostics will be prefixed by the file, line, and (optionally)
			 * column to which the diagnostic refers. This option corresponds to the
			 * clang flag '''-fshow-source-location'''.
			 */
			[CCode(cname = "CXDiagnostic_DisplaySourceLocation")]
			SOURCE_LOCATION,
			/**
			 * If displaying the source-location information of the diagnostic, also
			 * include the column number.
			 *
			 * This option corresponds to the clang flag '''-fshow-column'''.
			 */
			[CCode(cname = "CXDiagnostic_DisplayColumn")]
			COLUMN,
			/**
			 * If displaying the source-location information of the diagnostic, also
			 * include information about source ranges in a machine-parsable format.
			 *
			 * This option corresponds to the clang flag
			 * '''-fdiagnostics-print-source-range-info'''.
			 */
			[CCode(cname = "CXDiagnostic_DisplaySourceRanges")]
			SOURCE_RANGES,
			/**
			 * Display the option name associated with this diagnostic, if any.
			 *
			 * The option name displayed (e.g., '''-Wconversion''') will be placed in
			 * brackets after the diagnostic text. This option corresponds to the clang
			 * flag '''-fdiagnostics-show-option'''.
			 */
			[CCode(cname = "CXDiagnostic_DisplayOption")]
			OPTION,
			/**
			 * Display the category number associated with this diagnostic, if any.
			 *
			 * The category number is displayed within brackets after the diagnostic
			 * text. This option corresponds to the clang flag
			 * '''-fdiagnostics-show-category=id'''.
			 */
			[CCode(cname = "CXDiagnostic_DisplayCategoryId")]
			CATEGORY_ID,
			/**
			 * Display the category name associated with this diagnostic, if any.
			 *
			 * The category name is displayed within brackets after the diagnostic
			 * text. This option corresponds to the clang flag
			 * '''-fdiagnostics-show-category=name'''.
			 */
			[CCode(cname = "CXDiagnostic_DisplayCategoryName")]
			CATEGORY_NAME;
			/**
			 * Retrieve the set of display options most similar to the default
			 * behavior of the clang compiler.
			 */
			[CCode(cname = "clang_defaultDiagnosticDisplayOptions")]
			public static Display get_default();
		}
		/**
		 * Retrieve the name of a particular diagnostic category.
		 */
		[CCode(cname = "clang_getDiagnosticCategoryName")]
		public static String get_category_name(uint category);
		/**
		 * The number of the category that contains this diagnostic, or zero if
		 * this diagnostic is uncategorized.
		 *
		 * Diagnostics can be categorized into groups along with other, related
		 * diagnostics (e.g., diagnostics under the same warning flag). This
		 * routine retrieves the category number for the given diagnostic.
		 */
		 public uint category {
			 [CCode(cname = "clang_getDiagnosticCategory")]
			 get;
		 }
		/**
		 * The number of fix-it hints associated with the given diagnostic.
		 */
		public uint fix_it_count {
			[CCode(cname = "clang_getDiagnosticNumFixIts")]
			get;
		}
		/**
		 * The source location of the given diagnostic.
		 *
		 * This location is where Clang would print the caret ('^') when displaying
		 * the diagnostic on the command line.
		 */
		public source_location? location {
			[CCode(cname = "clang_getDiagnosticLocation")]
			get;
		}
		/**
		 * The number of source ranges associated with the given diagnostic.
		 */
		public uint range_count {
			 [CCode(cname = "clang_getDiagnosticNumRanges")]
			 get;
		}
		/**
		 * The severity of the given diagnostic.
		 */
		public Severity severity {
			[CCode(cname = "clang_getDiagnosticSeverity")]
			get;
		}
		/**
		 * The text of the given diagnostic.
		 */
		public String spelling {
			[CCode(cname = "clang_getDiagnosticSpelling")]
			owned get;
		}
		/**
		 * Format the given diagnostic in a manner that is suitable for display.
		 *
		 * This routine will format the given diagnostic to a string, rendering the
		 * diagnostic according to the various options given.
		 */
		[CCode(cname = "clang_formatDiagnostic")]
		public String format(Display options = Display.get_default());
		/**
		 * Retrieve the replacement information for a given fix-it.
		 *
		 * Fix-its are described in terms of a source range whose contents should
		 * be replaced by a string. This approach generalizes over three kinds of
		 * operations: removal of source code (the range covers the code to be
		 * removed and the replacement string is empty), replacement of source code
		 * (the range covers the code to be replaced and the replacement string
		 * provides the new code), and insertion (both the start and end of the
		 * range point at the insertion location, and the replacement string
		 * provides the text to insert).
		 * @param fix_it The zero-based index of the fix-it.
		 * @param replacement_range The source range whose contents will be
		 * replaced with the returned replacement string. Note that source
		 * ranges are half-open ranges [a, b), so the source code should be
		 * replaced from a and up to (but not including) b.
		 */
		 [CCode(cname = "clang_getDiagnosticFixIt")]
		 public String get_fix_it(uint fix_it, out source_range replacement_range);
		/**
		 * Retrieve the name of the command-line option that enabled this
		 * diagnostic.
		 *
		 * @param disable the option that disables this diagnostic (if any).
		 * @return A string that contains the command-line option used to enable
		 * this warning, such as "-Wconversion" or "-pedantic".
		 */
		[CCode(cname = "clang_getDiagnosticOption")]
		public String get_option(out String disable);
		/**
		 * Retrieve a source range associated with the diagnostic.
		 *
		 * A diagnostic's source ranges highlight important elements in the source
		 * code. On the command line, Clang displays source ranges by
		 * underlining them with '~' characters.
		 */
		[CCode(cname = "clang_getDiagnosticRange")]
		public source_range? get_range(uint range);
	}
	[CCode(cname = "struct CXTranslationUnitImpl", free_function = "")]
	[Compact]
	public class DiagnosticGroup {
		/**
		 * The number of diagnostics produced for the given translation unit.
		 */
		public uint size {
			[CCode(cname = "clang_getNumDiagnostics")]
			get;
		}
		/**
		 * Retrieve a diagnostic associated with the given translation unit.
		 *
		 * @param index the zero-based diagnostic number to retrieve.
		 */
		[CCode(cname = "clang_getDiagnostic")]
		public Diagnostic? get(uint index);
	}
	/**
	 * A particular source file that is part of a translation unit.
	 */
	[CCode(cname = "void")]
	public class File {
		/**
		 * The complete file and path name of the given file.
		 */
		public String name {
			[CCode(cname = "clang_getFileName")]
			get;
		}
		/**
		 * Retrieve the last modification time of the given file.
		 */
		public time_t mtime {
			[CCode(cname = "clang_getFileTime")]
			get;
		}
	}
	/**
	 * An "index" that consists of a set of translation units that would
	 * typically be linked together into an executable or library.
	 */
	[CCode(cname = "void", free_function = "clang_disposeIndex")]
	[Compact]
	public class Index {
		/**
		 * Provides a shared context for creating translation units.
		 * @param exclude_declarations_from_pch Allows enumeration of "local"
		 * declarations (when loading any new translation units). A "local"
		 * declaration is one that belongs in the translation unit itself and not
		 * in a precompiled header that was used by the translation unit. If false,
		 * all declarations will be enumerated.
		 */
		[CCode(cname = "clang_createIndex")]
		public Index(bool exclude_declarations_from_pch, bool display_diagnostics);
		/**
		 * Create a translation unit from an AST file (-emit-ast).
		 */
		[CCode(cname = "clang_createTranslationUnit")]
		public TranslationUnit? open_ast(string ast_filename);
		/**
		 * Return the translation unit for a given source file and the provided
		 * command line arguments one would pass to the compiler.
		 *
		 * @param source_filename The name of the source file to load, or null if
		 * the source file is included in next parameter.
		 *
		 * @param clang_command_line_args The command-line arguments that would be
		 * passed to the '''clang executable''' if it were being invoked
		 * out-of-process.  These command-line options will be parsed and will
		 * affect how the translation unit is parsed. Note that the following
		 * options are ignored: '''-c''', '''-emit-ast''', '''-fsyntax-only'''
		 * (which is the default), and '''-o <output file>'''.
		 * @param unsaved_files the files that have not yet been saved to disk but
		 * may be required for code completion, including the contents of those
		 * files. The contents and name of these files (as specified by
		 * {@link unsaved_file}) are copied when necessary, so the client only needs
		 * to guarantee their validity until the call to this function returns.
		 */
		 [CCode(cname = "clang_createTranslationUnitFromSourceFile")]
		 public TranslationUnit? open(string? source_filename, string[]? clang_command_line_args, unsaved_file[]? unsaved_files, TranslationUnit.Flags options = TranslationUnit.Flags.get_default());
	}
	/**
	 * A remapping of original source files and their translated files.
	 */
	[CCode(cname = "void", free_function = "clang_remap_dispose")]
	[Compact]
	public class Remapping {
		/**
		 * Retrieve a remapping.
		 *
		 * @param path the path that contains metadata about remappings.
		 * @return the requested remapping. May return null if an error occurred.
		 */
		[CCode(cname = "clang_getRemappings")]
		public static Remapping? open(string path);
		/**
		 * The number of remappings.
		 */
		public uint count {
			[CCode(cname = "clang_remap_getNumFiles")]
			get;
		}
		/**
		 * Get the original and the associated filename from the remapping.
		 *
		 * @param original the original filename.
		 * @param transformed the filename that the original is associated with.
		 */
		 [CCode(cname = "clang_remap_getFilenames")]
		 public void get_names(uint index, out String original, out String transformed);
	}
	/**
	 * The memory usage of a {@link TranslationUnit}, broken into categories.
	 */
	[CCode(cname = "CXTUResourceUsage", free_function = "clang_disposeCXTUResourceUsage")]
	[Compact]
	public class ResourceUsage {
		/**
		 * An array of key-value pairs, representing the breakdown of memory usage.
		 */
		[CCode(cname = "entries", array_length_cname = "numEntries")]
		public resource_usage_entry[] entries;
	}
	/**
	 * A character string.
	 *
	 * This type is used to return strings from the interface when the ownership
	 * of that string might different from one call to the next.
	 */
	[CCode(cname = "CXString", free_function = "clang_disposeString")]
	[Compact]
	public class String {
		/**
		 * The character data associated with the given string.
		 */
		public string str {
			[CCode(cname = "clang_getCString")]
			get;
		}
	}
	/**
	 * A single translation unit, which resides in an index.
	 */
	[CCode(cname = "struct CXTranslationUnitImpl", free_function = "clang_disposeTranslationUnit")]
	public class TranslationUnit {
		/**
		 * Flags that control the creation of translation units.
		 */
		[CCode(cname = "CXTranslationUnit_Flags")]
		[Flags]
		public enum Flags {
			/**
			 * Used to indicate that no special translation-unit options are needed.
			 */
			[CCode(cname = "CXTranslationUnit_None")]
			NONE,
			/**
			 * Used to indicate that the parser should construct a "detailed"
			 * preprocessing record, including all macro definitions and
			 * instantiations.
			 *
			 * Constructing a detailed preprocessing record requires more memory and
			 * time to parse, since the information contained in the record is
			 * usually not retained. However, it can be useful for applications that
			 * require more detailed information about the behavior of the
			 * preprocessor.
			 */
			[CCode(cname = "CXTranslationUnit_DetailedPreprocessingRecord")]
			DETAILED_PREPROCESSING_RECORD,
			/**
			 * Used to indicate that the translation unit is incomplete.
			 *
			 * When a translation unit is considered "incomplete", semantic analysis
			 * that is typically performed at the end of the translation unit will be
			 * suppressed. For example, this suppresses the completion of tentative
			 * declarations in C and of instantiation of implicitly-instantiation
			 * function templates in C++. This option is typically used when parsing
			 * a header with the intent of producing a precompiled header.
			 */
			[CCode(cname = "CXTranslationUnit_Incomplete")]
			INCOMPLETE,
			/**
			 * Used to indicate that the translation unit should be built with an
			 * implicit precompiled header for the preamble.
			 *
			 * An implicit precompiled header is used as an optimization when a
			 * particular translation unit is likely to be reparsed many times when
			 * the sources aren't changing that often. In this case, an implicit
			 * precompiled header will be built containing all of the initial
			 * includes at the top of the main file (what we refer to as the
			 * "preamble" of the file). In subsequent parses, if the preamble or the
			 * files in it have not changed, {@link TranslationUnit.reparse} will
			 * re-use the implicit precompiled header to improve parsing performance.
			 */
			[CCode(cname = "CXTranslationUnit_PrecompiledPreamble")]
			PRECOMPILED_PREAMBLE,
			/**
			 * Used to indicate that the translation unit should cache some
			 * code-completion results with each reparse of the source file.
			 *
			 * Caching of code-completion results is a performance optimization that
			 * introduces some overhead to reparsing but improves the performance of
			 * code-completion operations.
			 */
			[CCode(cname = "CXTranslationUnit_CacheCompletionResults")]
			Cache_Completion_Results,
			/**
			 * Enable precompiled preambles in C++.
			 *
			 * Note: this is a '''temporary''' option that is available only while we
			 * are testing C++ precompiled preamble support. It is deprecated.
			 */
			[CCode(cname = "CXTranslationUnit_CXXPrecompiledPreamble")]
			[Deprecated]
			CXX_PRECOMPILED_PREAMBLE,
			/**
			 * Enabled chained precompiled preambles in C++.
			 *
			 * Note: this is a '''temporary''' option that is available only while we
			 * are testing C++ precompiled preamble support. It is deprecated.
			 */
			[CCode(cname = "CXTranslationUnit_CXXChainedPCH")]
			[Deprecated]
			CXX_CHAINED_PCH,
			/**
			 * Used to indicate that the "detailed" preprocessing record, if
			 * requested, should also contain nested macro expansions.
			 *
			 * Nested macro expansions (i.e., macro expansions that occur inside
			 * another macro expansion) can, in some code bases, require a large
			 * amount of storage to due preprocessor metaprogramming. Moreover, its
			 * fairly rare that this information is useful for libclang clients.
			 */
			[CCode(cname = "CXTranslationUnit_NestedMacroExpansions")]
			NESTED_MACRO_EXPANSIONS;
			/**
			 * Returns the set of flags that is suitable for parsing a translation
			 * unit that is being edited.
			 *
			 * The set of flags returned provide options indicate that the
			 * translation unit is likely to be reparsed many times, either
			 * explicitly or implicitly (e.g., by code completion). The returned flag
			 * set contains an unspecified set of optimizations (e.g., the
			 * precompiled preamble) geared toward improving the performance of these
			 * routines. The set of optimizations enabled may change from one version
			 * to the next.
			 */
			[CCode(cname = "clang_defaultEditingTranslationUnitOptions")]
			public static Flags get_default();
		}
		/**
		 * Returns the set of flags that is suitable for reparsing a translation
		 * unit.
		 */
		public ReparseFlags default_reparse {
			[CCode(cname = "clang_defaultReparseOptions")]
			get;
		}
		/**
		 * The set of flags that is suitable for saving this translation unit.
		 */
		public SaveFlags default_save {
			[CCode(cname = "clang_defaultSaveOptions")]
			get;
		}
		public DiagnosticGroup diagnostics {
			[CCode(cname="")]
			get;
		}
		/**
		 * The original source file name.
		 */
		public String original_file_name {
			[CCode(cname = "clang_getTranslationUnitSpelling")]
			get;
		}
		/**
		 * Annotate the given set of tokens by providing cursors for each token
		 * that can be mapped to a specific entity within the abstract syntax tree.
		 *
		 * This token-annotation routine is equivalent to invoking
		 * {@link get_cursor} for the source locations of each of the tokens. The
		 * cursors provided are filtered, so that only those cursors that have a
		 * direct correspondence to the token are accepted.
		 * @param tokens the set of tokens to annotate.
		 * @param cursors an array of cursors of the same length, whose contents
		 * will be replaced with the cursors corresponding to each token.
		 */
		 [CCode(cname = "clang_annotateTokens")]
		 public void annotate_tokens([CCode(array_length_type = "unsigned")] token[] tokens, [CCode(array_length = false)] Cursor[] cursors);
		/**
		 * Perform code completion at a given location in a translation unit.
		 *
		 * This function performs code completion at a particular file, line, and
		 * column within source code, providing results that suggest potential code
		 * snippets based on the context of the completion. The basic model for
		 * code completion is that Clang will parse a complete source file,
		 * performing syntax checking up to the location where code-completion has
		 * been requested. At that point, a special code-completion token is passed
		 * to the parser, which recognizes this token and determines, based on the
		 * current location in the C/Objective-C/C++ grammar and the state of
		 * semantic analysis, what completions to provide.
		 *
		 * Code completion itself is meant to be triggered by the client when the
		 * user types punctuation characters or whitespace, at which point the
		 * code-completion location will coincide with the cursor. For example, if
		 * '''p''' is a pointer, code-completion might be triggered after the
		 * '''-''' and then after the '''>''' in '''p->'''. When the
		 * code-completion location is afer the '''>''', the completion results
		 * will provide, e.g., the members of the struct that '''p''' points to.
		 * The client is responsible for placing the cursor at the beginning of the
		 * token currently being typed, then filtering the results based on the
		 * contents of the token. For example, when code-completing for the
		 * expression '''p->get''', the client should provide the location just
		 * after the '''>''' (e.g., pointing at the '''g''') to this
		 * code-completion hook. Then, the client can filter the results based on
		 * the current token text ('''get'''), only showing those results that
		 * start with '''get'''. The intent of this interface is to separate the
		 * relatively high-latency acquisition of code-completion results from the
		 * filtering of results on a per-character basis, which must have a lower
		 * latency.
		 *
		 * The source files for this translation unit need not be completely
		 * up-to-date (and the contents of those source files may be overridden).
		 * Cursors referring into the translation unit may be invalidated by this
		 * invocation.
		 *
		 * @param complete_filename The name of the source file where code
		 * completion should be performed. This filename may be any file included
		 * in the translation unit.
		 *
		 * @param complete_line The line at which code-completion should occur.
		 *
		 * @param complete_column The column at which code-completion should occur.
		 * Note that the column should point just after the syntactic construct
		 * that initiated code completion, and not in the middle of a lexical
		 * token.
		 *
		 * @param unsaved_files the tiles that have not yet been saved to disk
		 * but may be required for parsing or code completion, including the
		 * contents of those files. The contents and name of these files (as
		 * specified by {@link unsaved_file}) are copied when necessary, so the
		 * client only needs to guarantee their validity until the call to this
		 * function returns.
		 */
		[CCode(cname = "clang_codeCompleteAt")]
		public Completion.Results complete_at(string complete_filename, uint complete_line, uint complete_column, [CCode(array_length_type = "unsigned")] unsaved_file[] unsaved_files, Completion.Flags options = Completion.Flags.get_default());
		/**
		 * Free the given set of tokens.
		 */
		[CCode(cname = "clang_disposeTokens")]
		public void dispose_tokens([CCode(array_length_type = "unsigned")] owned token[] tokens);
		/**
		 * Retrieve a file handle within the given translation unit.
		 * @param file_name the name of the file.
		 */
		[CCode(cname = "clang_getFile")]
		public File? get(string file_name);
		/**
		 * Retrieve the cursor that represents the given translation unit.
		 *
		 * The translation unit cursor can be used to start traversing the various
		 * declarations within the given translation unit.
		 */
		[CCode(cname = "clang_getTranslationUnitCursor")]
		public Cursor get_cursor();
		/**
		 * Map a source location to the cursor that describes the entity at that
		 * location in the source code.
		 *
		 * This maps an arbitrary source location within a translation unit down to
		 * the most specific cursor that describes the entity at that location.
		 */
		[CCode(cname = "clang_getCursor")]
		public Cursor get_cursor_by_location(source_location location);
		/**
		 * Retrieves the source location associated with a given file/line/column
		 * in a particular translation unit.
		 */
		[CCode(cname = "clang_getLocation")]
		public source_location? get_location(File file, uint line, uint column);
		/**
		 * Retrieves the source location associated with a given character offset
		 * in a particular translation unit.
		 */
		[CCode(cname = "clang_getLocationForOffset")]
		public source_location? get_location_for_offset(File file, uint offset);
		/**
		 * Return the memory usage of a translation unit.
		 */
		[CCode(cname = "clang_getCXTUResourceUsage")]
		public ResourceUsage get_resource_usage();
		/**
		 * Retrieve a source range that covers the given token.
		 */
		[CCode(cname = "clang_getTokenExtent")]
		public source_range? get_token_extent(token token);
		/**
		 * Retrieve the source location of the given token.
		 */
		[CCode(cname = "clang_getTokenLocation")]
		public source_location? get_token_location(token token);
		/**
		 * Determine the spelling of the given token.
		 *
		 * The spelling of a token is the textual representation of that token, e.g.,
		 * the text of an identifier or keyword.
		 */
		[CCode(cname = "clang_getTokenSpelling")]
		public String get_token_spelling(token token);
		/**
		 * Determine whether the given header is guarded against multiple inclusions,
		 * either with the conventional #ifndef/#define/#endif macro guards or with
		 * #pragma once.
		 */
		[CCode(cname = "clang_isFileMultipleIncludeGuarded")]
		public bool is_file_multiple_include_guarded(File file);
		/**
		 * Reparse the source files that produced this translation unit.
		 *
		 * This routine can be used to re-parse the source files that originally
		 * created the given translation unit, for example because those source
		 * files have changed (either on disk or as passed via unsaved files). The
		 * source code will be reparsed with the same command-line options as it
		 * was originally parsed.
		 *
		 * Reparsing a translation unit invalidates all cursors and source
		 * locations that refer into that translation unit. This makes reparsing a
		 * translation unit semantically equivalent to destroying the translation
		 * unit and then creating a new translation unit with the same command-line
		 * arguments.  However, it may be more efficient to reparse a translation
		 * unit using this routine.
		 *
		 * The translation unit must originally have been built with
		 * {@link Index.open}.
		 *
		 * @param unsaved_files The files that have not yet been saved to disk but
		 * may be required for parsing, including the contents of those files. The
		 * contents and name of these files (as specified by {@link unsaved_file})
		 * are copied when necessary, so the client only needs to guarantee their
		 * validity until the call to this function returns.
		 * \returns false if the sources could be reparsed. True will be returned
		 * if reparsing was impossible, such that the translation unit is invalid.
		 * In such cases, the translation unit must be disposed.
		 */
		[CCode(cname = "clang_reparseTranslationUnit")]
		public bool reparse([CCode(array_length_pos = 0.2)] unsaved_file[] unsaved_files, ReparseFlags options = default_reparse);
		/**
		 * Saves a translation unit into a serialized representation of that
		 * translation unit on disk.
		 *
		 * Any translation unit that was parsed without error can be saved into a
		 * file. The translation unit can then be deserialized using
		 * {@link Index.open_ast} or, if it is an incomplete translation unit that
		 * corresponds to a header, used as a precompiled header when parsing other
		 * translation units.
		 *
		 * @param file_name The file to which the translation unit will be saved.
		 */
		[CCode(cname = "clang_saveTranslationUnit")]
		public SaveError save(string file_name, SaveFlags options = default_save);
		/**
		 * Tokenize the source code described by the given range into raw lexical
		 * tokens.
		 *
		 * @param range the source range in which text should be tokenized. All of
		 * the tokens produced by tokenization will fall within this source range.
		 * @see dispose_tokens
		 */
		[CCode(cname = "clang_tokenize")]
		public void tokenize(source_range range, [CCode(array_length_type = "unsigned")] out token[] tokens);
		/**
		 * Visit the set of preprocessor inclusions in a translation unit.
		 *
		 * The visitor function is called with the provided data for every included
		 * file. This does not include headers included by the PCH file (unless one
		 * is inspecting the inclusions in the PCH file itself).
		 */
		[CCode(cname = "clang_getInclusions")]
		public void trace_inclusions(InclusionVisitor visitor);
	}
	/**
	 * A cursor representing some element in the abstract syntax tree for a
	 * translation unit.
	 *
	 * The cursor abstraction unifies the different kinds of entities in a
	 * program–declaration, statements, expressions, references to declarations,
	 * etc.–under a single "cursor" abstraction with a common set of operations.
	 * Common operation for a cursor include: getting the physical location in a
	 * source file where the cursor points, getting the name associated with a
	 * cursor, and retrieving cursors for any child nodes of a particular cursor.
	 *
	 * Cursors can be produced in two specific ways.
	 * {@link TranslationUnit.get_cursor} produces a cursor for a translation
	 * unit, from which one can use {@link visit_children} to explore the rest of
	 * the translation unit. {@link TranslationUnit.get_cursor_by_location} maps
	 * from a physical source location to the entity that resides at that
	 * location, allowing one to map from the source code into the AST.
	 */
	[CCode(cname = "CXCursor")]
	[SimpleType]
	public struct Cursor {
		/**
		 * Retrieve the null cursor, which represents no entity.
		 */
		[CCode(cname = "clang_getNullCursor")]
		public static Cursor? get_null();
		/**
		 * The access control level for the C++ base specifier represented by a
		 * cursor with kind {@link CursorKind.CXX_BASE_SPECIFIER} or
		 * {@link CursorKind.CXX_ACCESS_SPECIFIER}.
		 */
		public AccessSpecifier access {
			[CCode(cname = "clang_getCXXAccessSpecifier")]
			get;
		}
		/**
		 * The availability of the entity that this cursor refers to.
		 */
		public Availability availability {
			[CCode(cname = "clang_getCursorAvailability")]
			get;
		}
		/**
		 * The display name for the entity referenced by this cursor.
		 *
		 * The display name contains extra information that helps identify the
		 * cursor, such as the parameters of a function or template or the
		 * arguments of a class template specialization.
		 */
		public String display_name {
			[CCode(cname = "clang_getCursorDisplayName")]
			get;
		}
		/**
		 * The physical extent of the source construct.
		 *
		 * The extent of a cursor starts with the file/line/column pointing at the
		 * first character within the source construct that the cursor refers to
		 * and ends with the last character withinin that source construct. For a
		 * declaration, the extent covers the declaration itself. For a reference,
		 * the extent covers the location of the reference (e.g., where the
		 * referenced entity was actually used).
		 */
		public source_range? extent {
			[CCode(cname = "clang_getCursorExtent")]
			get;
		}
		/**
		 * The file that is included by the given inclusion directive cursor.
		 */
		public File file {
			[CCode(cname = "clang_getIncludedFile")]
			get;
		}
		/**
		 * Compute a hash value for the given cursor.
		 */
		public uint hash {
			[CCode(cname = "clang_hashCursor")]
			get;
		}
		/**
		 * The IB outlet collection element type, if the cursor is represeting such a collection.
		 */
		public Type ib_outlet_type {
			[CCode(cname = "clang_getIBOutletCollectionType")]
			get;
		}
		/**
		 * Whether the declaration pointed to by this cursor is also a definition
		 * of that entity.
		 */
		public bool is_definition {
			[CCode(cname = "clang_isCursorDefinition")]
			get;
		}
		/**
		 * Determine if a C++ member function or member function template is
		 * declared 'static'.
		 */
		public bool is_static {
			[CCode(cname = "clang_CXXMethod_isStatic")]
			get;
		}
		/**
		 * Determine if a C++ member function or member function template is
		 * explicitly declared 'virtual' or if it overrides a virtual method from
		 * one of the base classes.
		 */
		public bool is_virtual {
			[CCode(cname = "clang_CXXMethod_isVirtual")]
			get;
		}
		/**
		 * If base class specified by the cursor with kind
		 * {@link CursorKind.CXX_BASE_SPECIFIER} is virtual.
		 */
		public bool is_virtual_base {
			[CCode(cname = "clang_isVirtualBase")]
			get;
		}
		/**
		 * The kind of the given cursor.
		 */
		public CursorKind kind {
			[CCode(cname = "clang_getCursorKind")]
			get;
		}
		/**
		 * Determine the "language" of the entity referred to by a given cursor.
		 */
		public Language language {
			[CCode(cname = "clang_getCursorLanguage")]
			get;
		}
		/**
		 * Determine the linkage of the entity referred to by a given cursor.
		 */
		public Linkage linkage {
			[CCode(cname = "clang_getCursorLinkage")]
			get;
		}
		/**
		 * The physical location of the source constructor.
		 *
		 * The location of a declaration is typically the location of the name of
		 * that declaration, where the name of that declaration would occur if it
		 * is unnamed, or some keyword that introduces that particular declaration.
		 * The location of a reference is where that reference occurs within the
		 * source code.
		 */
		public source_location? location {
			[CCode(cname = "clang_getCursorLocation")]
			get;
		}
		/**
		 * The Objective-C type encoding for the specified declaration.
		 */
		public String objc_type_encoding {
			[CCode(cname = "clang_getDeclObjCTypeEncoding")]
			owned get;
		}
		/**
		 * The number of overloaded declarations referenced by a
		 * {@link CursorKind.OVERLOADED_DECL_REF} cursor.
		 */
		public uint overloaded_count {
			 [CCode(cname = "clang_getNumOverloadedDecls")]
			 get;
		}
		/**
		 * A name for the entity referenced by this cursor.
		 */
		public String spelling {
			[CCode(cname = "clang_getCursorSpelling")]
			owned get;
		}
		/**
		 * The translation unit that a cursor originated from.
		 */
		public TranslationUnit tu {
			[CCode(cname = "clang_Cursor_getTranslationUnit")]
			get;
		}
		public Type? type {
			[CCode(cname = "clang_getCursorType")]
			get;
		}
		/**
		 * Retrieve a Unified Symbol Resolution (USR) for the entity referenced by
		 * the given cursor.
		 *
		 * A Unified Symbol Resolution (USR) is a string that identifies a
		 * particular entity (function, class, variable, etc.) within a program.
		 * USRs can be compared across translation units to determine, e.g., when
		 * references in one translation refer to an entity defined in another
		 * translation unit.
		 */
		public String usr {
			[CCode(cname = "clang_getCursorUSR")]
			owned get;
		}
		/**
		 * Determine whether two cursors are equivalent.
		 */
		[CCode(cname = "clang_equalCursors")]
		public bool equals(Cursor other);
		/**
		 * Find references of a declaration in a specific file.
		 *
		 * @param file to search for references.
		 * @param visitor callback that will receive pairs of {@link Cursor}/{@link source_range}
		 * for each reference found. The range will point inside the file; if the
		 * reference is inside a macro (and not a macro argument) the range will be
		 * invalid.
		 */
		public void find_references_in_file(File file, CursorAndRangeVisitor visitor) {
			cursor_and_range_visitor v = cursor_and_range_visitor();
			v.visit = visitor;
			_find_references_in_file(file, v);
		}
		[CCode(cname = "clang_findReferencesInFile")]
		private void _find_references_in_file(File file, cursor_and_range_visitor visitor);
		/**
		 * Retrieve the canonical cursor corresponding to the given cursor.
		 *
		 * In the C family of languages, many kinds of entities can be declared
		 * several times within a single translation unit. For example, a structure
		 * type can be forward-declared (possibly multiple times) and later
		 * defined.
		 *
		 * One of these cursor is considered the "canonical" cursor, which is
		 * effectively the representative for the underlying entity. One can
		 * determine if two cursors are declarations of the same underlying entity
		 * by comparing their canonical cursors.
		 */
		[CCode(cname = "clang_getCanonicalCursor")]
		public Cursor get_caonical_cursor();
		/**
		 * Retrieve a completion string for an arbitrary declaration or macro
		 * definition cursor.
		 * @return A non-context-sensitive completion string for declaration and
		 * macro definition cursors, or null for other kinds of cursors.
		 */
		[CCode(cname = "clang_getCursorCompletionString")]
		public Completion.String? get_completion();
		/**
		 * For a cursor that is either a reference to or a declaration
		 * of some entity, retrieve a cursor that describes the definition of
		 * that entity.
		 *
		 * Some entities can be declared multiple times within a translation
		 * unit, but only one of those declarations can also be a
		 * definition.
		 *
		 * If given a cursor for which there is no corresponding definition, e.g.,
		 * because there is no definition of that entity within this translation
		 * unit, returns a null cursor.
		 */
		[CCode(cname = "clang_getCursorDefinition")]
		public Cursor get_definition();
		[CCode(cname = "clang_getDefinitionSpellingAndExtent")]
		public void get_definition_spelling(out char* start_buf, out char* end_buf, out uint start_line, out uint start_column, out uint end_line, out uint end_column);
		/**
		 * Determine the lexical parent of the given cursor.
		 *
		 * The lexical parent of a cursor is the cursor in which the given cursor
		 * was actually written. For many declarations, the lexical and semantic
		 * parents are equivalent. They diverge when declarations or definitions
		 * are provided out-of-line.
		 *
		 * For declarations written in the global scope, the lexical parent is the
		 * translation unit.
		 */
		[CCode(cname = "clang_getCursorLexicalParent")]
		public Cursor get_lexical_parent();
		/**
		 * Retrieve a cursor for one of the overloaded declarations referenced
		 * by a {@link CursorKind.OVERLOADED_DECL_REF} cursor.
		 * @param index The zero-based index into the set of overloaded
		 * declarations in the cursor.
		 * @return A cursor representing the declaration referenced by the given
		 * cursor at the specified index.
		 */
		[CCode(cname = "clang_getOverloadedDecl")]
		public Cursor? get_overloaded_decl(uint index);
		/**
		 * Determine the set of methods that are overridden by the given method.
		 *
		 * In both Objective-C and C++, a method (aka virtual member function, in
		 * C++) can override a virtual method in a base class. For Objective-C, a
		 * method is said to override any method in the class's interface (if we're
		 * coming from an implementation), its protocols, or its categories, that
		 * has the same selector and is of the same kind (class or instance). If no
		 * such method exists, the search continues to the class's superclass, its
		 * protocols, and its categories, and so on.
		 *
		 * For C++, a virtual member function overrides any virtual member function
		 * with the same signature that occurs in its base classes. With multiple
		 * inheritance, a virtual member function can override several virtual
		 * member functions coming from different base classes.
		 *
		 * In all cases, this function determines the immediate overridden method,
		 * rather than all of the overridden methods. For example, if a method is
		 * originally declared in a class A, then overridden in B (which in
		 * inherits from A) and also in C (which inherited from B), then the only
		 * overridden method returned from this function when invoked on C's method
		 * will be B's method. The client may then invoke this function again,
		 * given the previously-found overridden methods, to map out the complete
		 * method-override set.
		 */
		[CCode(cname = "clang_getOverriddenCursors")]
		public void get_overridden_cursors(out Cursor[] overridden);
		/**
		 * Given a cursor that references something else, return the source range
		 * covering that reference.
		 *
		 * The cursor must be pointing to a member reference, a declaration
		 * reference, or an operator call.
		 * @param piece_index For contiguous names or when passing the flag
		 * {@link NameRef.WANT_SINGLE_PIECE}, only one piece with index 0 is
		 * available. When that flag is not passed for a non-contiguous names, this
		 * index can be used to retreive the individual pieces of the name.
		 * @return The piece of the name pointed to by the given cursor.
		 */
		[CCode(cname = "clang_getCursorReferenceNameRange")]
		public source_range? get_reference_name_range(NameRef name_flags, uint piece_index);
		/**
		 * For a cursor that is a reference, retrieve a cursor representing the
		 * entity that it references.
		 *
		 * Reference cursors refer to other entities in the AST. For example, an
		 * Objective-C superclass reference cursor refers to an Objective-C class.
		 * This function produces the cursor for the Objective-C class from the
		 * cursor for the superclass reference. If the input cursor is a
		 * declaration or definition, it returns that declaration or definition
		 * unchanged.Otherwise, returns the null cursor.
		 */
		[CCode(cname = "clang_getCursorReferenced")]
		public Cursor get_referenced();
		/**
		 * Retrieve the result type associated with a given cursor.
		 *
		 * This only returns a valid type of the cursor refers to a function or
		 * method.
		 */
		[CCode(cname = "clang_getCursorResultType")]
		public Type get_result_type();
		/**
		 * Determine the semantic parent of the given cursor.
		 *
		 * The semantic parent of a cursor is the cursor that semantically contains
		 * the given cursor. For many declarations, the lexical and semantic
		 * parents are equivalent. They diverge when declarations or definitions
		 * are provided out-of-line.
		 *
		 * For global declarations, the semantic parent is the translation unit.
		 */
		[CCode(cname = "clang_getCursorSemanticParent")]
		public Cursor get_semantic_parent();
		/**
		 * Given a cursor that may represent a specialization or instantiation of a
		 * template, retrieve the cursor that represents the template that it
		 * specializes or from which it was instantiated.
		 *
		 * This routine determines the template involved both for explicit
		 * specializations of templates and for implicit instantiations of the
		 * template, both of which are referred to as "specializations". For a
		 * class template specialization (e.g., \c std::vector<bool>), this routine
		 * will return either the primary template (\c std::vector) or, if the
		 * specialization was instantiated from a class template partial
		 * specialization, the class template partial specialization. For a class
		 * template partial specialization and a function template specialization
		 * (including instantiations), this this routine will return the
		 * specialized template.
		 *
		 * For members of a class template (e.g., member functions, member classes,
		 * or static data members), returns the specialized or instantiated member.
		 * Although not strictly "templates" in the C++ language, members of class
		 * templates have the same notions of specializations and instantiations
		 * that templates do, so this routine treats them similarly.
		 *
		 * @return If the given cursor is a specialization or instantiation of a
		 * template or a member thereof, the template or member that it specializes
		 * or from which it was instantiated. Otherwise, returns a null cursor.
		 */
		[CCode(cname = "clang_getSpecializedCursorTemplate")]
		public Cursor get_template_cursor();
		/**
		 * Given a cursor that represents a template, determine the cursor kind of
		 * the specializations would be generated by instantiating the template.
		 *
		 * This can be used to determine what flavor of function template, class
		 * template, or class template partial specialization is stored in the
		 * cursor. For example, it can describe whether a class template cursor is
		 * declared with "struct", "class" or "union".
		 */
		[CCode(cname = "clang_getTemplateCursorKind")]
		public CursorKind get_template_cursor_kind();
		/**
		 * Visit the children of a particular cursor.
		 *
		 * This function visits all the direct children of the given cursor,
		 * invoking the given visitor function with the cursors of each visited
		 * child. The traversal may be recursive, if the visitor returns
		 * {@link ChildVisitResult.RECURSE}. The traversal may also be ended
		 * prematurely, if the visitor returns {@link ChildVisitResult.BREAK}.
		 *
		 * All kinds of cursors can be visited, including invalid cursors (which,
		 * by definition, have no children).
		 *
		 * @return false if the traversal was terminated prematurely by the visitor
		 * returning {@link ChildVisitResult.BREAK}.
		 */
		[CCode(cname = "clang_visitChildren")]
		public bool visit_children(CursorVisitor visitor);
	}
	/**
	 * The type of an element in the abstract syntax tree.
	 *
	 */
	[CCode(cname = "CXType")]
	[SimpleType]
	public struct Type {
		/**
		 * Whether the "const" qualifier set, without looking through typedefs that
		 * may have added "const" at a different level.
		 */
		public bool is_const_qualified {
			[CCode(cname = "clang_isConstQualifiedType")]
			get;
		}
		/**
		 * Is a POD (plain old data) type
		 */
		public bool is_pod {
			[CCode(cname = "clang_isPODType")]
			get;
		}
		/**
		 * Whether the "restrict" qualifier set, without looking through typedefs
		 * that may have added "restrict" at a different level.
		 */
		public bool is_restrict_qualified {
			[CCode(cname = "clang_isRestrictQualifiedType")]
			get;
		}
		/**
		 * Whether the "volatile" qualifier set, without looking through typedefs
		 * that may have added "volatile" at a different level.
		 */
		public bool is_volatile_qualified {
			[CCode(cname = "clang_isVolatileQualifiedType")]
			get;
		}
		/**
		 * Determine whether two CXTypes represent the same type.
		 */
		[CCode(cname = "clang_equalTypes")]
		public bool equals(Type other);
		/**
		 * Return the canonical type.
		 *
		 * Clang's type system explicitly models typedefs and all the ways a
		 * specific type can be represented. The canonical type is the underlying
		 * type with all the "sugar" removed. For example, if '''T''' is a typedef
		 * for '''int''', the canonical type for '''T''' would be '''int'''.
		 */
		[CCode(cname = "clang_getCanonicalType")]
		public Type canonicalize();
		/**
		 * Return the element type of an array type.
		 *
		 * If a non-array type is passed in, an invalid type is returned.
		 */
		[CCode(cname = "clang_getArrayElementType")]
		public Type get_array_element_type();
		/**
		 * Return the the array size of a constant array.
		 *
		 * If a non-array type, -1 is returned.
		 */
		[CCode(cname = "clang_getArraySize")]
		public int64 get_array_size();
		/**
		 * Return the cursor for the declaration of the given type.
		 */
		[CCode(cname = "clang_getTypeDeclaration")]
		public Cursor get_declaration();
		/**
		 * For pointer types, returns the type of the pointee.
		 */
		[CCode(cname = "clang_getPointeeType")]
		public Type get_pointee();
		/**
		 * Retrieve the result type associated with a function type.
		 */
		[CCode(cname = "clang_getResultType")]
		public Type get_result();
	}
	[CCode(cname = "CXTUResourceUsageEntry")]
	public struct resource_usage_entry {
		/**
		 * The memory usage category.
		 */
		public Resource kind;
		/**
		 * Amount of resources used.
		 *
		 * The units will depend on the resource kind.
		 */
		public ulong amount;
	}
	/**
	 * Identifies a specific source location within a translation
	 * unit.
	 */
	[CCode(cname = "CXSourceLocation", destroy_function = "")]
	public struct source_location {
		/**
		 * Retrieve a NULL (invalid) source location.
		 */
		[CCode(cname = "clang_getNullLocation")]
		public static source_location? get_null();
		/**
		 * Determine whether two source locations, which must refer into the same
		 * translation unit, refer to exactly the same point in the source code.
		 */
		[CCode(cname = "clang_equalLocations")]
		public bool equals(source_location other);
		/**
		 * Retrieve the file, line, column, and offset represented by the given
		 * source location.
		 *
		 * If the location refers into a macro expansion, retrieves the location of
		 * the macro expansion.
		 *
		 * @param file the file to which the given source location points.
		 * @param line the line to which the given source location points.
		 * @param column the column to which the given source location points.
		 * @param offset the offset into the buffer to which the given source
		 * location points.
		 */
		[CCode(cname = "clang_getExpansionLocation")]
		public void get_location(out unowned File file, out uint line, out uint column, out uint offset);
		/**
		 * Retrieve the file, line, column, and offset represented by
		 * the given source location, as specified in a #line directive.
		 *
		 * @param filename the filename of the source location. Note that filenames
		 * returned will be for "virtual" files, which don't necessarily exist on
		 * the machine running clang (e.g., when parsing preprocessed output
		 * obtained from a different environment).
		 * @param line the line number of the source location.
		 * @param column the column number of the source location.
		 */
		[CCode(cname = "clang_getPresumedLocation")]
		public void get_presumed_location(out String filename, out uint line, out uint column);
		/**
		 * Retrieve a source range given the beginning and ending source locations.
		 */
		[CCode(cname = "clang_getRange")]
		public source_range? get_range(source_location end);
		/**
		 * Retrieve the file, line, column, and offset represented by the given
		 * source location.
		 *
		 * If the location refers into a macro instantiation, return where the
		 * location was originally spelled in the source file.
		 *
		 * @param file the file to which the given source location points.
		 * @param line the line to which the given source location points.
		 * @param column the column to which the given source location points.
		 * @param offset the offset into the buffer to which the given source
		 * location points.
		 */
		[CCode(cname = "clang_getSpellingLocation")]
		public void get_spelling_location(out unowned File file, out uint line, out uint column, out uint offset);
	}
	/**
	 * Identifies a half-open character range in the source code.
	 */
	[CCode(cname = "CXSourceRange", destroy_function = "")]
	public struct source_range {
		/**
		 * Retrieve a NULL (invalid) source range.
		 */
		[CCode(cname = "clang_getNullRange")]
		public static source_range? get_null();
		/**
		 * Source location representing the last character.
		 */
		 public source_location? end {
		 	[CCode(cname = "clang_getRangeEnd")]
			 get;
		 }
		/**
		 * If range is null (empty).
		 */
		public bool is_null {
			[CCode(cname = "clang_Range_isNull")]
			get;
		}
		/**
		 * Source location representing the first character.
		 */
		public source_location? start {
			[CCode(cname = "clang_getRangeStart")]
			get;
		}
		/**
		 * Determine whether two ranges are equivalent.
		 */
		[CCode(cname = "clang_equalRanges")]
		public bool equals(source_range other);
	}
	/**
	 * Describes a single preprocessing token.
	 */
	[CCode(cname = "CXToken")]
	public struct token {
		/**
		 * The kind of the given token.
		 */
		public TokenKind kind {
			[CCode(cname = "clang_getTokenKind")]
			get;
		}
	}
	/**
	 * Provides the contents of a file that has not yet been saved to disk.
	 *
	 * Each instance provides the name of a file on the system along with the
	 * current contents of that file that have not yet been saved to disk.
	 */
	[CCode(cname = "struct CXUnsavedFile", has_destroy_function = false)]
	public struct unsaved_file {
		/**
		 * A buffer containing the unsaved contents of this file.
		 */
		[CCode(cname = "Contents", array_length_type = "unsigned long", array_length_cname = "Length")]
		public uint8[] contents;
		/**
		 * The file whose contents have not yet been saved.
		 *
		 * This file must already exist in the file system.
		 */
		[CCode(cname = "Filename")]
		public string filename;
	}
	[CCode(cname = "void", instance_pos = 0)]
	public delegate VisitorResult CursorAndRangeVisitor(Cursor cursor, source_range extent);
	/**
	 * Visitor invoked for each cursor found by a traversal.
	 *
	 * This visitor function will be invoked for each cursor found.
	 * @param cursor the cursor being visited.
	 * @param parent the parent visitor for that cursor
	 */
	[CCode(cname = "CXCursorVisitor")]
	public delegate ChildVisitResult CursorVisitor(Cursor cursor, Cursor parent);
	/**
	 * Visitor invoked for each file in a translation unit.
	 *
	 * This visitor function will be invoked for each file included (either at
	 * the top-level or by #include directives) within a translation unit. The
	 * first argument is the file being included, and the second and third
	 * arguments provide the inclusion stack. The array is sorted in order of
	 * immediate inclusion. For example, the first element refers to the
	 * location that included 'included_file'.
	 */
	[CCode(cname = "CXInclusionVisitor")]
	public delegate void InclusionVisitor(File included_file, [CCode(array_length_type = "unsigned")] source_location[] inclusion_stack);
	/**
	 * Construct a USR for a specified Objective-C category.
	 */
	[CCode(cname = "clang_constructUSR_ObjCCategory")]
	public String construct_usr_objc_category(string class_name, string category_name);
	/**
	 * Construct a USR for a specified Objective-C class.
	 */
	[CCode(cname = "clang_constructUSR_ObjCClass")]
	public String construct_usr_objc_class(string class_name);
	/**
	 * Construct a USR for a specified Objective-C instance variable and the USR
	 * for its containing class.
	 */
	[CCode(cname = "clang_constructUSR_ObjCIvar")]
	public String construct_usr_objc_ivar(string name, String class_usr);
	/**
	 * Construct a USR for a specified Objective-C method and the USR for its
	 * containing class.
	 */
	[CCode(cname = "clang_constructUSR_ObjCMethod")]
	public String construct_usr_objc_method(string name, bool is_instance_method, String class_usr);
	/**
	 * Construct a USR for a specified Objective-C property and the USR for its
	 * containing class.
	 */
	[CCode(cname = "clang_constructUSR_ObjCProperty")]
	public String construct_usr_objc_property(string property, String class_usr);
	/**
	 * Construct a USR for a specified Objective-C protocol.
	 */
	[CCode(cname = "clang_constructUSR_ObjCProtocol")]
	public String construct_usr_objc_protocol(string protocol_name);
	[CCode(cname = "clang_enableStackTraces")]
	public void enable_stack_traces();
	[CCode(cname = "clang_executeOnThread")]
	public void execute_on_thread(GLib.VoidFunc func, uint stack_size);
	/**
	 * Return a version string, suitable for showing to a user, but not intended
	 * to be parsed (the format is not guaranteed to be stable).
	 */
	[CCode(cname = "clang_getClangVersion")]
	public String get_version();
	/**
	 * Enable/disable crash recovery.
	 */
	[CCode(cname = "clang_toggleCrashRecovery")]
	public void set_crash_recovery(bool is_enabled);
	/**
	 * Code completion
	 *
	 * Code completion involves taking an (incomplete) source file, along with
	 * knowledge of where the user is actively editing that file, and suggesting
	 * syntactically- and semantically-valid constructs that the user might want
	 * to use at that particular point in the source code. These data structures
	 * and routines provide support for code completion.
	 */
	namespace Completion {
		/**
		 * Describes a single piece of text within a code-completion string.
		 *
		 * Each "chunk" within a code-completion {@link String} is either a piece
		 * of text with a specific "kind" that describes how that text should be
		 * interpreted by the client or is another completion string.
		 */
		[CCode(cname = "enum CXCompletionChunkKind")]
		public enum ChunkKind {
			/**
			 * A code-completion string that describes "optional" text that could be
			 * a part of the template (but is not required).
			 *
			 * This chunk is the only kind of chunk that has a code-completion string
			 * for its representation, which is accessible via
			 * {@link Completion.String.get}. The code-completion string describes an
			 * additional part of the template that is completely optional.  For
			 * example, optional chunks can be used to describe the placeholders for
			 * arguments that match up with defaulted function parameters.
			 *
			 * There are many ways to handle Optional chunks. Two simple approaches are:
			 * - Completely ignore optional chunks, in which case the template for
			 * the function "f" would only include the first parameter ("int x").
			 * - Fully expand all optional chunks, in which case the template for the
			 * function "f" would have all of the parameters.
			 */
			[CCode(cname = "CXCompletionChunk_Optional")]
			OPTIONAL,
			/**
			 * Text that a user would be expected to type to get this code-completion
			 * result.
			 *
			 * There will be exactly one "typed text" chunk in a semantic string,
			 * which will typically provide the spelling of a keyword or the name of
			 * a declaration that could be used at the current code point. Clients
			 * are expected to filter the code-completion results based on the text
			 * in this chunk.
			 */
			[CCode(cname = "CXCompletionChunk_TypedText")]
			TYPED_TEXT,
			/**
			 * Text that should be inserted as part of a code-completion result.
			 *
			 * A "text" chunk represents text that is part of the template to be
			 * inserted into user code should this particular code-completion result
			 * be selected.
			 */
			[CCode(cname = "CXCompletionChunk_Text")]
			TEXT,
			/**
			 * Placeholder text that should be replaced by the user.
			 *
			 * A "placeholder" chunk marks a place where the user should insert text
			 * into the code-completion template. For example, placeholders might mark
			 * the function parameters for a function declaration, to indicate that the
			 * user should provide arguments for each of those parameters. The actual
			 * text in a placeholder is a suggestion for the text to display before
			 * the user replaces the placeholder with real code.
			 */
			[CCode(cname = "CXCompletionChunk_Placeholder")]
			PLACEHOLDER,
			/**
			 * Informative text that should be displayed but never inserted as
			 * part of the template.
			 *
			 * An "informative" chunk contains annotations that can be displayed to
			 * help the user decide whether a particular code-completion result is the
			 * right option, but which is not part of the actual template to be inserted
			 * by code completion.
			 */
			[CCode(cname = "CXCompletionChunk_Informative")]
			INFORMATIVE,
			/**
			 * Text that describes the current parameter when code-completion is
			 * referring to function call, message send, or template specialization.
			 *
			 * A "current parameter" chunk occurs when code-completion is providing
			 * information about a parameter corresponding to the argument at the
			 * code-completion point.
			 */
			[CCode(cname = "CXCompletionChunk_CurrentParameter")]
			CURRENT_PARAMETER,
			/**
			 * A left parenthesis ('('), used to initiate a function call or
			 * signal the beginning of a function parameter list.
			 */
			[CCode(cname = "CXCompletionChunk_LeftParen")]
			LEFT_PAREN,
			/**
			 * A right parenthesis (')'), used to finish a function call or
			 * signal the end of a function parameter list.
			 */
			[CCode(cname = "CXCompletionChunk_RightParen")]
			RIGHT_PAREN,
			/**
			 * A left bracket ('[').
			 */
			[CCode(cname = "CXCompletionChunk_LeftBracket")]
			LEFT_BRACKET,
			/**
			 * A right bracket (']').
			 */
			[CCode(cname = "CXCompletionChunk_RightBracket")]
			RIGHT_BRACKET,
			/**
			 * A left brace ('{').
			 */
			[CCode(cname = "CXCompletionChunk_LeftBrace")]
			LEFT_BRACE,
			/**
			 * A right brace ('}').
			 */
			[CCode(cname = "CXCompletionChunk_RightBrace")]
			RIGHT_BRACE,
			/**
			 * A left angle bracket ('<').
			 */
			[CCode(cname = "CXCompletionChunk_LeftAngle")]
			LEFT_ANGLE,
			/**
			 * A right angle bracket ('>').
			 */
			[CCode(cname = "CXCompletionChunk_RightAngle")]
			RIGHT_ANGLE,
			/**
			 * A comma separator (',').
			 */
			[CCode(cname = "CXCompletionChunk_Comma")]
			COMMA,
			/**
			 * Text that specifies the result type of a given result.
			 *
			 * This special kind of informative chunk is not meant to be inserted into
			 * the text buffer. Rather, it is meant to illustrate the type that an
			 * expression using the given completion string would have.
			 */
			[CCode(cname = "CXCompletionChunk_ResultType")]
			RESULT_TYPE,
			/**
			 * A colon (':').
			 */
			[CCode(cname = "CXCompletionChunk_Colon")]
			COLON,
			/**
			 * A semicolon (';').
			 */
			[CCode(cname = "CXCompletionChunk_SemiColon")]
			SEMICOLON,
			/**
			 * An '=' sign.
			 */
			[CCode(cname = "CXCompletionChunk_Equal")]
			EQUAL,
			/**
			 * Horizontal space (' ').
			 */
			[CCode(cname = "CXCompletionChunk_HorizontalSpace")]
			HORIZONTAL_SPACE,
			/**
			 * Vertical space ('\n'), after which it is generally a good idea to
			 * perform indentation.
			 */
			[CCode(cname = "CXCompletionChunk_VerticalSpace")]
			VERTICAL_SPACE
		}
		/**
		 * Bits that represent the context under which completion is occurring.
		 */
		[CCode(cname = "enum CXCompletionContext")]
		public enum Context {
			/**
			 * The context for completions is unexposed, as only Clang results
			 * should be included. (This is equivalent to having no context bits set.)
			 */
			[CCode(cname = "CXCompletionContext_Unexposed")]
			UNEXPOSED,
			/**
			 * Completions for any possible type should be included in the results.
			 */
			[CCode(cname = "CXCompletionContext_AnyType")]
			ANY_TYPE,
			/**
			 * Completions for any possible value (variables, function calls, etc.)
			 * should be included in the results.
			 */
			[CCode(cname = "CXCompletionContext_AnyValue")]
			ANY_VALUE,
			/**
			 * Completions for values that resolve to an Objective-C object should
			 * be included in the results.
			 */
			[CCode(cname = "CXCompletionContext_ObjCObjectValue")]
			OBJC_OBJECT_VALUE,
			/**
			 * Completions for values that resolve to an Objective-C selector
			 * should be included in the results.
			 */
			[CCode(cname = "CXCompletionContext_ObjCSelectorValue")]
			OBJC_SELECTOR_VALUE,
			/**
			 * Completions for values that resolve to a C++ class type should be
			 * included in the results.
			 */
			[CCode(cname = "CXCompletionContext_CXXClassTypeValue")]
			CXX_CLASS_TYPE_VALUE,
			/**
			 * Completions for fields of the member being accessed using the dot
			 * operator should be included in the results.
			 */
			[CCode(cname = "CXCompletionContext_DotMemberAccess")]
			DOT_MEMBER_ACCESS,
			/**
			 * Completions for fields of the member being accessed using the arrow
			 * operator should be included in the results.
			 */
			[CCode(cname = "CXCompletionContext_ArrowMemberAccess")]
			Arrow_Member_Access,
			/**
			 * Completions for properties of the Objective-C object being accessed
			 * using the dot operator should be included in the results.
			 */
			[CCode(cname = "CXCompletionContext_ObjCPropertyAccess")]
			OBJC_PROPERTY_ACCESS,
			/**
			 * Completions for enum tags should be included in the results.
			 */
			[CCode(cname = "CXCompletionContext_EnumTag")]
			ENUM_TAG,
			/**
			 * Completions for union tags should be included in the results.
			 */
			[CCode(cname = "CXCompletionContext_UnionTag")]
			UNION_TAG,
			/**
			 * Completions for struct tags should be included in the results.
			 */
			[CCode(cname = "CXCompletionContext_StructTag")]
			STRUCT_TAG,
			/**
			 * Completions for C++ class names should be included in the results.
			 */
			[CCode(cname = "CXCompletionContext_ClassTag")]
			CLASS_TAG,
			/**
			 * Completions for C++ namespaces and namespace aliases should be
			 * included in the results.
			 */
			[CCode(cname = "CXCompletionContext_Namespace")]
			NAMESPACE,
			/**
			 * Completions for C++ nested name specifiers should be included in
			 * the results.
			 */
			[CCode(cname = "CXCompletionContext_NestedNameSpecifier")]
			NESTED_NAME_SPECIFIER,
			/**
			 * Completions for Objective-C interfaces (classes) should be included
			 * in the results.
			 */
			[CCode(cname = "CXCompletionContext_ObjCInterface")]
			OBJC_INTERFACE,
			/**
			 * Completions for Objective-C protocols should be included in
			 * the results.
			 */
			[CCode(cname = "CXCompletionContext_ObjCProtocol")]
			OBJC_PROTOCOL,
			/**
			 * Completions for Objective-C categories should be included in
			 * the results.
			 */
			[CCode(cname = "CXCompletionContext_ObjCCategory")]
			OBJC_CATEGORY,
			/**
			 * Completions for Objective-C instance messages should be included
			 * in the results.
			 */
			[CCode(cname = "CXCompletionContext_ObjCInstanceMessage")]
			OBJC_INSTANCE_MESSAGE,
			/**
			 * Completions for Objective-C class messages should be included in
			 * the results.
			 */
			[CCode(cname = "CXCompletionContext_ObjCClassMessage")]
			OBJC_CLASS_MESSAGE,
			/**
			 * Completions for Objective-C selector names should be included in
			 * the results.
			 */
			[CCode(cname = "CXCompletionContext_ObjCSelectorName")]
			OBJC_SELECTOR_NAME,
			/**
			 * Completions for preprocessor macro names should be included in
			 * the results.
			 */
			[CCode(cname = "CXCompletionContext_MacroName")]
			MACRO_NAME,
			/**
			 * Natural language completions should be included in the results.
			 */
			[CCode(cname = "CXCompletionContext_NaturalLanguage")]
			NATURAL_LANGUAGE,
			/**
			 * The current context is unknown, so set all contexts.
			 */
			[CCode(cname = "CXCompletionContext_Unknown")]
			UNKNOWN
		}
		[CCode(cname = "enum CXCodeComplete_Flags")]
		[Flags]
		public enum Flags {
			/**
			 * Whether to include macros within the set of code completions returned.
			 */
			[CCode(cname = "CXCodeComplete_IncludeMacros")]
			INCLUDE_MACROS,
			/**
			 * Whether to include code patterns for language constructs within the
			 * set of code completions, e.g., for loops.
			 */
			[CCode(cname = "CXCodeComplete_IncludeCodePatterns")]
			INCLUDE_CODE_PATTERNS;
			/**
			 * Returns a default set of code-completion options.
			 */
			[CCode(cname = "clang_defaultCodeCompleteOptions")]
			public static Flags get_default();
		}
		[CCode(cname = "void")]
		[Compact]
		public class Annotations {
			/**
			 * Retrieve the number of annotations associated with the given
			 * completion string.
			 */
			public uint size {
				[CCode(cname = "clang_getCompletionNumAnnotations")]
				get;
			}
			/**
			 * Retrieve the annotation associated with the given completion string.
			 *
			 * @param annotation_number the 0-based index of the annotation of the
			 * completion string.
			 */
			[CCode(cname = "clang_getCompletionAnnotation")]
			public String? get(uint annotation_number);
		}
		[CCode(cname = "CXCodeCompleteResults", free_function = "")]
		[Compact]
		public class Diagnostics {
			/**
			 * The number of diagnostics produced prior to the location where code
			 * completion was performed.
			 */
			public uint size {
				[CCode(cname = "clang_codeCompleteGetNumDiagnostics")]
				get;
			}
			/**
			 * Retrieve a diagnostic associated with the given code completion.
			 *
			 * @param index the zero-based diagnostic number to retrieve.
			 */
			[CCode(cname = "clang_codeCompleteGetDiagnostic")]
			public Diagnostic? get(uint index);
		}
		/**
		 * Contains the results of code-completion.
		 */
		[CCode(cname = "CXCodeCompleteResults", free_function = "clang_disposeCodeCompleteResults")]
		[Compact]
		public class Results {
			/**
			 * What completions are appropriate for the context the given code
			 * completion.
			 */
			public Context contexts {
				[CCode(cname = "clang_codeCompleteGetContexts")]
				get;
			}
			public Diagnostics diagnostics {
				[CCode(cname = "")]
				get;
			}
			/**
			 * The currently-entered selector for an Objective-C message send
			 *
			 * Formatted like "initWithFoo:bar:". Only guaranteed to be a non-empty
			 * string for {@link Context.OBJC_INSTANCE_MESSAGE} and
			 * {@link Context.OBJC_CLASS_MESSAGE}.
			 */
			public String? objc_selector {
				[CCode(cname = "clang_codeCompleteGetObjCSelector")]
				owned get;
			}
			/**
			 * The USR for the container for the current code completion context.
			 *
			 * If there is not a container for the current context, this function will
			 * return the empty string.
			 */
			public String? usr_container {
				[CCode(cname = "clang_codeCompleteGetContainerUSR")]
				owned get;
			}
			/**
			 * The code-completion results.
			 */
			[CCode(cname = "Results", array_length_cname = "NumResults")]
			public result[] results;
			/**
			 * Returns the cursor kind for the container for the current code
			 * completion context.
			 *
			 * The container is only guaranteed to be set for contexts where a
			 * container exists (i.e., member accesses or Objective-C message sends);
			 * if there is not a container, this function will return
			 * {@link CursorKind.INVALID_CODE}.
			 *
			 * @param is_incomplete on return, this value will be false if Clang has
			 * complete information about the container. If Clang does not have
			 * complete information, this value will be true.
			 */
			[CCode(cname = "clang_codeCompleteGetContainerKind")]
			public CursorKind get_cursor_kind(out bool is_incomplete);
		}
		/**
		 * A semantic string that describes a code-completion result.
		 *
		 * A semantic string that describes the formatting of a code-completion
		 * result as a single "template" of text that should be inserted into the
		 * source buffer when a particular code-completion result is selected.
		 * Each semantic string is made up of some number of "chunks", each of
		 * which contains some text along with a description of what that text
		 * means, e.g., the name of the entity being referenced, whether the text
		 * chunk is part of the template, or whether it is a "placeholder" that the
		 * user should replace with actual code, of a specific kind.
		 * @see ChunkKind
		 */
		[CCode(cname = "void")]
		public class String {
			public Annotations annotations {
				[CCode(cname = "")]
				get;
			}
			/**
			 * Determine the availability of the entity that this code-completion
			 * string refers to.
			 */
			public Availability availability {
				[CCode(cname = "clang_getCompletionAvailability")]
				get;
			}
			/**
			 * The priority of this code completion.
			 *
			 * The priority of a code completion indicates how likely it is that this
			 * particular completion is the completion that the user will select. The
			 * priority is selected by various internal heuristics.
			 *
			 * Smaller values indicate higher-priority (more likely) completions.
			 */
			public uint priority {
				[CCode(cname = "clang_getCompletionPriority")]
				get;
			}
			/**
			 * The number of chunks in the given code-completion string.
			 */
			public uint size {
				[CCode(cname = "clang_getNumCompletionChunks")]
				get;
			}
			/**
			 * Retrieve the completion string associated with a particular chunk
			 * within a completion string.
			 *
			 * @param chunk_number the 0-based index of the chunk in the completion string.
			 * @return the completion string associated with the chunk.
			 */
			[CCode(cname = "clang_getCompletionChunkCompletionString")]
			public String get(uint chunk_number);
			/**
			 * Determine the kind of a particular chunk within a completion string.
			 * @param chunk_number the 0-based index of the chunk in the completion string.
			 * @return the kind of the chunk at the index specified.
			 */
			[CCode(cname = "clang_getCompletionChunkKind")]
			public ChunkKind get_kind(uint chunk_number);
			/**
			 * Retrieve the text associated with a particular chunk within a
			 * completion string.
			 *
			 * @param chunk_number the 0-based index of the chunk in the completion string.
			 * @return the text associated with the chunk at index specified.
			 */
			[CCode(cname = "clang_getCompletionChunkText")]
			public Clang.String get_text(uint chunk_number);
		}
		/**
		 * A single result of code completion.
		 */
		[CCode(cname = "CXCompletionResult")]
		public struct result {
			/**
			 * The kind of entity that this completion refers to.
			 *
			 * The cursor kind will be a macro, keyword, or a declaration, describing
			 * the entity that the completion is referring to.
			 */
			[CCode(cname = "CursorKind")]
			public CursorKind kind;
			/**
			 * The code-completion string that describes how to insert this
			 * code-completion result into the editing buffer.
			 */
			[CCode(cname = "CompletionString")]
			public String str;
		}
		/**
		 * Sort the code-completion results in case-insensitive alphabetical
		 * order.
		 *
		 * @param results The set of results to sort.
		 */
		[CCode(cname = "clang_sortCodeCompletionResults")]
		public void sort([CCode(array_length_type = "unsigned")]result[] results);
	}
	[CCode(cname = "CXCursorAndRangeVisitor")]
	private struct cursor_and_range_visitor{
		[CCode(cname = "CXVisitorResult", target_cname = "context")]
		public unowned CursorAndRangeVisitor visit;
	}
}
