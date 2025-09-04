# Makefile for generating gRPC Swift files from Protocol Buffer definitions
# This automates the generation of Swift protobuf messages and gRPC service clients

# Directories
PROTO_DIR = .
GENERATED_DIR = Generated

# Proto files - Added upload.proto
PROTO_FILES = user.proto

# Tools
PROTOC = protoc
PROTOC_GEN_SWIFT = protoc-gen-swift
PROTOC_GEN_GRPC_SWIFT = protoc-gen-grpc-swift

# Default target
.PHONY: all
all: generate

# Generate all Swift files from proto definitions
.PHONY: generate
generate: generate-messages generate-services
	@echo "✅ All gRPC Swift files generated successfully"

# Generate Swift protobuf messages
.PHONY: generate-messages
generate-messages:
	@echo "🔄 Generating Swift protobuf messages..."
	@mkdir -p $(GENERATED_DIR)
	$(PROTOC) \
		--proto_path=$(PROTO_DIR) \
		--swift_out=$(GENERATED_DIR) \
		$(PROTO_FILES)
	@echo "✅ Swift protobuf messages generated"

# Generate gRPC Swift service clients
.PHONY: generate-services
generate-services:
	@echo "🔄 Generating gRPC Swift service clients..."
	@mkdir -p $(GENERATED_DIR)
	$(PROTOC) \
		--proto_path=$(PROTO_DIR) \
		--plugin=/opt/homebrew/bin/protoc-gen-grpc-swift \
		--grpc-swift_out=$(GENERATED_DIR) \
		$(PROTO_FILES)
	@echo "✅ gRPC Swift service clients generated"

# Clean generated files
.PHONY: clean
clean:
	@echo "🧹 Cleaning generated files..."
	@rm -rf $(GENERATED_DIR)/*.pb.swift
	@rm -rf $(GENERATED_DIR)/*.grpc.swift
	@echo "✅ Generated files cleaned"

# Verify tools are installed
.PHONY: check-tools
check-tools:
	@echo "🔍 Checking required tools..."
	@which $(PROTOC) > /dev/null || (echo "❌ protoc not found. Install with: brew install protobuf" && exit 1)
	@which $(PROTOC_GEN_SWIFT) > /dev/null || (echo "❌ protoc-gen-swift not found. Install with: brew install swift-protobuf" && exit 1)
	@which $(PROTOC_GEN_GRPC_SWIFT) > /dev/null || (echo "❌ protoc-gen-grpc-swift not found. Install with: brew install grpc-swift" && exit 1)
	@echo "✅ All required tools are installed"

# Show help
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  generate          - Generate all Swift files (messages + services)"
	@echo "  generate-messages - Generate only Swift protobuf messages"
	@echo "  generate-services - Generate only gRPC Swift service clients"
	@echo "  clean            - Remove all generated files"
	@echo "  check-tools      - Verify required tools are installed"
	@echo "  help             - Show this help message"
	@echo ""
	@echo "Generated files will be placed in: $(GENERATED_DIR)/"
	@echo "Proto files processed: $(PROTO_FILES)"