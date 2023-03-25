Feature: Better

  Background:
    Given I have the following config
      """
      <?xml version="1.0"?>
      <psalm>
        <projectFiles><directory name="."/></projectFiles>
        <stubs>
            <file name="../../stubs-better/LoggerInterface.phpstub" />
            <file name="../../stubs-better/AbstractLogger.phpstub" />
        </stubs>
      </psalm>
      """
    And I have the following code preamble
      """
      <?php
      use Psr\Log\LoggerInterface;
      use Psr\Log\AbstractLogger;

      /**
       * @psalm-suppress InvalidReturnType
       * @return LoggerInterface
       */
      function impl_interface() {}

      /**
       * @psalm-suppress InvalidReturnType
       * @return AbstractLogger
       */
      function concrete_abstract() {}

      """

  Scenario: non-empty-string key
    Given I have the following code
      """
      impl_interface()->emergency("message", [1 => 'non-key']);
      impl_interface()->emergency("message", ['exception' => 'foo']);
      concrete_abstract()->emergency("message", ['non-key']);
      concrete_abstract()->emergency("message", ['exception' => 'foo']);
      """
    When I run Psalm
    Then I see these errors
      | Type            | Message                                                                                                                      |
      | InvalidArgument | Argument 2 of Psr\Log\LoggerInterface::emergency expects array{exception?: Throwable, ...<non-empty-string, mixed>}, but array{exception: 'foo'} provided |
      | InvalidArgument | Argument 2 of Psr\Log\AbstractLogger::emergency expects array{exception?: Throwable, ...<non-empty-string, mixed>}, but array{exception: 'foo'} provided |
      | InvalidArgument | Argument 2 of Psr\Log\LoggerInterface::emergency expects array{exception?: Throwable, ...<non-empty-string, mixed>}, but array{exception: 'foo'} provided |
      | InvalidArgument | Argument 2 of Psr\Log\AbstractLogger::emergency expects array{exception?: Throwable, ...<non-empty-string, mixed>}, but array{exception: 'foo'} provided |
    And I see no other errors

