<?php

namespace SfpDev\Stubs\Psr\Log;

use PHPStan\PhpDocParser\Ast\PhpDoc\GenericTagValueNode;

final class BetterLoggerContextTypeRector extends AbstractLoggerContextTypeRector
{
    public function getLoggerContextTypeTagValueNode(): GenericTagValueNode
    {
        return new GenericTagValueNode('LoggerContextType = array<non-empty-string, mixed>&array{exception?: \Throwable}');
    }
}