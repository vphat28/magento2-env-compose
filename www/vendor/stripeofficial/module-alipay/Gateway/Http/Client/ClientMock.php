<?php

namespace Stripeofficial\Alipay\Gateway\Http\Client;

use Magento\Framework\Exception\LocalizedException;
use Magento\Payment\Gateway\Http\TransferInterface;
use Stripeofficial\Core\Gateway\Http\Client\ClientMock as CoreClientMock;

class ClientMock extends CoreClientMock
{
    /**
     * Places request to gateway. Returns result as ENV array
     *
     * @param TransferInterface $transferObject
     * @return array
     * @throws LocalizedException
     */
    public function placeRequest(TransferInterface $transferObject)
    {
        $body = $transferObject->getBody();

        if ($body['TXN_TYPE'] == 'refund') {
            return $this->placeRefundRequest($body);
        }

        if ($body['TXN_TYPE'] == 'invoice_refund_only') {
            return $this->getRefund($body['TXN_ID']);
        }

        if ($body['TXN_TYPE'] == 'capture') {
            return $this->placeCaptureOnlyRequest($body);
        }

        $source = $this->creditCardPayment->getSource($body['STRIPE_TOKEN'])->jsonSerialize();

        if ($source['status'] != 'chargeable') {
            return $source;
        }

        return null;
    }
}
