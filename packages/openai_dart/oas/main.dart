import 'dart:io';

import 'package:openapi_spec/openapi_spec.dart';

/// Generates Chroma API client Dart code from the OpenAPI spec.
/// Official spec: https://github.com/openai/openai-openapi/blob/master/openapi.yaml
void main() async {
  final spec = OpenApi.fromFile(source: 'oas/openapi_curated.yaml');
  await spec.generate(
    package: 'OpenAI',
    destination: 'lib/src/generated/',
    replace: true,
    schemaOptions: const SchemaGeneratorOptions(
      onSchemaName: _onSchemaName,
      onSchemaUnionFactoryName: _onSchemaUnionFactoryName,
    ),
    clientOptions: const ClientGeneratorOptions(
      enabled: true,
    ),
  );
  await Process.run(
    'dart',
    ['run', 'build_runner', 'build', 'lib', '--delete-conflicting-outputs'],
  );
}

String? _onSchemaName(final String schemaName) => switch (schemaName) {
      'ChatCompletionUserMessageContentListChatCompletionMessageContentPart' =>
        'ChatCompletionMessageContentParts',
      _ => schemaName,
    };

String? _onSchemaUnionFactoryName(
  final String union,
  final String unionSubclass,
) =>
    switch (unionSubclass) {
      // Chat Completion
      'ChatCompletionModelEnumeration' => 'model',
      'ChatCompletionModelString' => 'modelId',
      'ChatCompletionSystemMessage' => 'system',
      'ChatCompletionUserMessage' => 'user',
      'ChatCompletionAssistantMessage' => 'assistant',
      'ChatCompletionToolMessage' => 'tool',
      'ChatCompletionFunctionMessage' => 'function',
      'ChatCompletionMessageContentParts' => 'parts',
      'ChatCompletionMessageContentPartText' => 'text',
      'ChatCompletionMessageContentPartImage' => 'image',
      'ChatCompletionToolChoiceOptionEnumeration' => 'mode',
      'ChatCompletionToolChoiceOptionChatCompletionNamedToolChoice' => 'tool',
      'ChatCompletionFunctionCallEnumeration' => 'mode',
      'ChatCompletionFunctionCallChatCompletionFunctionCallOption' =>
        'function',
      // Completion
      'CompletionModelEnumeration' => 'model',
      'CompletionModelString' => 'modelId',
      'CompletionPromptListInt' => 'tokens',
      'CompletionPromptListListInt' => 'listTokens',
      // Embeddings
      'EmbeddingModelEnumeration' => 'model',
      'EmbeddingModelString' => 'modelId',
      'EmbeddingVectorListDouble' => 'vector',
      'EmbeddingVectorString' => 'vectorBase64',
      'EmbeddingInputListInt' => 'tokens',
      'EmbeddingInputListListInt' => 'listTokens',
      // FineTuning
      'FineTuningModelEnumeration' => 'model',
      'FineTuningModelString' => 'modelId',
      'FineTuningNEpochsEnumeration' => 'mode',
      'FineTuningNEpochsInt' => 'number',
      // Images
      'CreateImageRequestModelEnumeration' => 'model',
      'CreateImageRequestModelString' => 'modelId',
      // Moderations
      'ModerationModelEnumeration' => 'model',
      'ModerationModelString' => 'modelId',
      // Assistant
      'AssistantModelEnumeration' => 'model',
      'AssistantModelString' => 'modelId',
      'MessageContentImageFileObject' => 'imageFile',
      'MessageDeltaContentImageFileObject' => 'imageFile',
      'MessageContentTextObject' => 'text',
      'MessageDeltaContentTextObject' => 'text',
      'MessageContentTextAnnotationsFileCitationObject' => 'fileCitation',
      'MessageDeltaContentTextAnnotationsFileCitationObject' => 'fileCitation',
      'MessageContentTextAnnotationsFilePathObject' => 'filePath',
      'MessageDeltaContentTextAnnotationsFilePathObject' => 'filePath',
      'RunModelEnumeration' => 'model',
      'RunModelString' => 'modelId',
      'ThreadAndRunModelEnumeration' => 'model',
      'ThreadAndRunModelString' => 'modelId',
      'RunStepDetailsToolCallsCodeObject' => 'codeInterpreter',
      'RunStepDeltaStepDetailsToolCallsCodeObject' => 'codeInterpreter',
      'RunStepDetailsToolCallsRetrievalObject' => 'retrieval',
      'RunStepDeltaStepDetailsToolCallsRetrievalObject' => 'retrieval',
      'RunStepDetailsToolCallsFunctionObject' => 'function',
      'RunStepDeltaStepDetailsToolCallsFunctionObject' => 'function',
      'RunStepDetailsToolCallsCodeOutputLogsObject' => 'logs',
      'RunStepDeltaStepDetailsToolCallsCodeOutputLogsObject' => 'logs',
      'RunStepDetailsToolCallsCodeOutputImageObject' => 'image',
      'RunStepDeltaStepDetailsToolCallsCodeOutputImageObject' => 'image',
      'RunStepDetailsMessageCreationObject' => 'messageCreation',
      'RunStepDeltaStepDetailsMessageCreationObject' => 'messageCreation',
      'RunStepDetailsToolCallsObject' => 'toolCalls',
      'RunStepDeltaStepDetailsToolCallsObject' => 'toolCalls',
      'CreateRunRequestResponseFormatEnumeration' => 'mode',
      'CreateThreadAndRunRequestResponseFormatEnumeration' => 'mode',
      'RunObjectResponseFormatEnumeration' => 'mode',
      'CreateAssistantRequestResponseFormatEnumeration' => 'mode',
      'ModifyAssistantRequestResponseFormatEnumeration' => 'mode',
      'CreateRunRequestResponseFormatAssistantsResponseFormat' => 'format',
      'CreateThreadAndRunRequestResponseFormatAssistantsResponseFormat' =>
        'format',
      'RunObjectResponseFormatAssistantsResponseFormat' => 'format',
      'CreateAssistantRequestResponseFormatAssistantsResponseFormat' =>
        'format',
      'ModifyAssistantRequestResponseFormatAssistantsResponseFormat' =>
        'format',
      'CreateRunRequestToolChoiceEnumeration' => 'mode',
      'CreateThreadAndRunRequestToolChoiceEnumeration' => 'mode',
      'RunObjectToolChoiceEnumeration' => 'mode',
      'CreateRunRequestToolChoiceAssistantsNamedToolChoice' => 'tool',
      'CreateThreadAndRunRequestToolChoiceAssistantsNamedToolChoice' => 'tool',
      'RunObjectToolChoiceAssistantsNamedToolChoice' => 'tool',
      _ => null,
    };
