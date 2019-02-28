<?php

namespace Stripeofficial\Core\Gateway\Validator;

use Magento\Payment\Gateway\Validator\AbstractValidator;
use Magento\Payment\Gateway\Validator\ResultInterface;
use Stripe\Charge;

class ResponseCodeValidator extends AbstractValidator
{
    const SUCCESS_CODE = 'succeeded';

    /**
     * Performs validation of result code
     *
     * @param array $validationSubject
     * @return ResultInterface
     */
    public function validate(array $validationSubject)
    {
        if (!isset($validationSubject['response'])) {
            throw new \InvalidArgumentException('Response does not exist');
        }

        $response = $validationSubject['response'];

        if ($this->isSuccessfulTransaction($response)) {
            return $this->createResult(
                true,
                []
            );
        } else {
            return $this->createResult(
                false,
                [__('Gateway rejected the transaction.')]
            );
        }
    }

    /**
     * @param Charge $response
     * @return bool
     */
    private function isSuccessfulTransaction($response)
    {
        if (isset($response['object']) && $response['object'] == 'refund') {
            return true;
        }

        if (isset($response['status']) && $response['status'] == self::SUCCESS_CODE) {
            return true;
        }

        if (isset($response['flow']) && $response['flow'] == 'redirect') {
            return true;
        }

        return false;
    }
}
