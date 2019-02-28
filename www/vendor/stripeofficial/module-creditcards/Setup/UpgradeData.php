<?php

namespace Stripeofficial\CreditCards\Setup;

use Magento\Cms\Api\BlockRepositoryInterface;
use Magento\Cms\Model\BlockFactory;
use Magento\Framework\Setup\ModuleContextInterface;
use Magento\Framework\Setup\ModuleDataSetupInterface;
use Magento\Framework\Setup\UpgradeDataInterface;

class UpgradeData implements UpgradeDataInterface
{
    /**
     * @var BlockRepositoryInterface
     */
    protected $blockRepository;

    /**
     * @var BlockFactory
     */
    protected $blockFactory;

    /**
     * UpgradeData constructor.
     * @param BlockRepositoryInterface $blockRepository
     * @param BlockFactory $blockFactory
     */
    public function __construct(
        BlockRepositoryInterface $blockRepository,
        BlockFactory $blockFactory
    ) {
        $this->blockRepository = $blockRepository;
        $this->blockFactory = $blockFactory;
    }

    /**
     * @param ModuleDataSetupInterface $setup
     * @param ModuleContextInterface $context
     * @throws
     */
    public function upgrade(
        ModuleDataSetupInterface $setup,
        ModuleContextInterface $context
    ) {
        $mcContent = <<<'EOD'
<p>MasterCard SecureCode is a system that provides additional protection when you use your MasterCard to shop online. The SecureCode is basically an extra passcode that provides a secondary level of protection.</p>
<p>&nbsp;</p>
<p>When you sign up for MasterCard SecureCode, you choose a personal passcode on your card issuer's website. This passcode is then used by your card issuer to verify your identity during the checkout process when you're shopping online. The passcode is known only to you and the card issuer -- retailers can't see it.</p>
EOD;

        $visaContent = <<<'EOD2'
<p>"Verified by Visa" is the secure
online payment services to provide you with extra security and peace of mind
when you shop online with your personal Credit Cards.</p>
<p>• An extra level of protection and security for shopping online<br>
• Available at no additional cost<br>
• Easy-to-use services with no software to download</p>
EOD2;
        if (version_compare($context->getVersion(), '2.0.1')) {
            try {
                $block = $this->blockFactory->create();
                $block->setData('content', $mcContent);
                $block->setData('title', 'Stripe MasterCard Learn More');
                $block->setData('identifier', 'stripe_mastercard_learn_more');
                $this->blockRepository->save($block);
                $block = $this->blockFactory->create();
                $block->setData('content', $visaContent);
                $block->setData('title', 'Stripe Visa Learn More');
                $block->setData('identifier', 'stripe_visa_learn_more');
                $this->blockRepository->save($block);
            } catch (\Exception $e) {
                // DO NOTHING
            }
        }
    }
}
