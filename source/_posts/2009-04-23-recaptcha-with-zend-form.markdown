--- 
layout: post
title: ReCaptcha with Zend Form
date: 2009-04-23 14:43:03 +02:00
categories: [zend, captcha, php]
comments: true
---
<h3>Requirements</h3>
<ul>
	<li><a href="http://framework.zend.com/download/" target="_blank">Zend Framework</a> (1.7.8 at writing time)</li>
	<li>Valid <a href="http://recaptcha.net/" target="_blank">ReCaptcha</a> keys (public &amp; private)</li>
</ul>
<h3>Simple ReCaptcha</h3>
<h4>Zend Form Class</h4>
{% codeblock application/forms/ReCaptcha.php lang:php %}
<?php
class Form_ReCaptcha extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
        //Add your elements here...

        $recaptcha = new Zend_Service_ReCaptcha($publickey, $privatekey);

        $captcha = new Zend_Form_Element_Captcha('challenge',
              array('captcha'        => 'ReCaptcha',
                    'captchaOptions' => array('captcha' => 'ReCaptcha', 'service' => $recaptcha)));
        
        $this->addElement($captcha);

        // Add the submit button
        $this->addElement('submit', 'submit', array('label' => 'Submit'));
    }
}
?>
{% endcodeblock %}

<h4>Zend Controller Class</h4>
{% codeblock application/controller/ReCaptchaController.php lang:php %}
<?php
class ReCaptchaController extends Zend_Controller_Action
{
    public function indexAction()
    {
        require_once APPLICATION_PATH . '/forms/Contact.php';

        $form = new Form_ReCaptcha();

        if ($this->_request->isPost()) {
            $formData = $this->_request->getPost();
            if ($form->isValid($formData)) {
                $recaptcha = new Zend_Service_ReCaptcha($publickey, $privatekey);

                $result = $recaptcha->verify($this->_getParam('recaptcha_challenge_field'),
                                             $this->_getParam('recaptcha_response_field'));
                if (!$result->isValid()) {
                    //ReCaptcha validation error
                    //Your action here...
               }
            }
        }   
        $this->view->form = $form;
    }
}
?>
{% endcodeblock %}

<h3>Customized ReCaptcha</h3>
You may also want to internationalizing or change colors to ReCaptcha, to do it you need to specify some options for the  Zend_Service_ReCaptcha object.
See the <a href="http://wiki.recaptcha.net/index.php/Main_Page" target="_blank">ReCaptcha wiki</a> for a complete list of available options. 

<h4>Zend Form Class</h4>

{% codeblock application/forms/ReCaptcha.php lang:php  %}
<?php
class Form_ReCaptcha extends Zend_Form
{
    public function init()
    {
        $this->setMethod('post');
        //Add your elements here...
        $recaptcha = new Zend_Service_ReCaptcha($publickey, $privatekey);
        
        //Translate in your language
        $recaptcha_it_translation = 
            array('visual_challenge' => "Verifica video",
                  'audio_challenge' => "Verifica audio",
                  'refresh_btn' => "Effettua una nuova verifica",
                  'instructions_visual' => "Scrivi le due parole",
                  'instructions_audio' => "Scrivi quello che ascolti",
                  'help_btn' => "Aiuto",
                  'play_again' => "Riascolto di nuovo l'audio",
                  'cant_hear_this' => "Scarica l'audio come MP3",
                  'incorrect_try_again' => "Incorretto. Prova ancora.");

        $recaptcha->setOption('custom_translations', $recaptcha_it_translation);
        //Change theme
        $recaptcha->setOption('theme', 'clean');

        $captcha = new Zend_Form_Element_Captcha('challenge',
              array('captcha'        => 'ReCaptcha',
                    'captchaOptions' => array('captcha' => 'ReCaptcha',
                                             'service' => $recaptcha)));
        
        $this->addElement($captcha);

        // Add the submit button
        $this->addElement('submit', 'submit', array('label' => 'Submit'));
    }
}
?>
{% endcodeblock %}
