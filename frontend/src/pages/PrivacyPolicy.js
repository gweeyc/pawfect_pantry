import React, { useEffect } from 'react';
import $ from 'jquery';
import 'jquery-ui-dist/jquery-ui';
import 'jquery-ui-dist/jquery-ui.css';
import './css/PrivacyPolicy.css';

const PrivacyPolicy = () => {
  useEffect(() => {
    // Delay activation to ensure DOM is ready
    const timer = setTimeout(() => {
      if ($('#privacy-left').length && $('#privacy-right').length) {
        $('#privacy-left, #privacy-right').accordion({
          collapsible: true,
          heightStyle: 'content'
        });
      } else {
        console.warn('Accordion elements not found.');
      }
    }, 150); // Slight delay to wait for DOM render

    return () => clearTimeout(timer);
  }, []);

  return (
    <div className="container privacy-policy py-5">
      <h2 className="text-center mb-4">Privacy Policy<img src="/media/images/guinea-pig.png" alt="Guinea Pig" className="guinea-pig" /></h2>
      <div className="row">
        <div className="col-md-6">
          <div id="privacy-left">
            <h3>1. What Information We Collect</h3>
            <div>
              <p>We collect personal data including your name, email, billing/shipping address, payment details, order history, and product preferences.</p>
            </div>

            <h3>2. How We Use Your Information</h3>
            <div>
              <p>To process your orders, personalize your shopping experience, provide customer service, send newsletters, and analyze trends.</p>
            </div>

            <h3>3. Payment and Security</h3>
            <div>
              <p>We use secure payment gateways with industry-standard encryption. No card details are stored on our servers.</p>
            </div>

            <h3>4. Cookies and Tracking</h3>
            <div>
              <p>We use cookies to store cart sessions, login preferences, and website analytics. You can disable cookies via browser settings.</p>
            </div>

            <h3>5. Email and Notifications</h3>
            <div>
              <p>By registering, you agree to receive order updates and marketing. You can unsubscribe anytime via the link in emails.</p>
            </div>

            <h3>6. Third-Party Tools</h3>
            <div>
              <p>We may use services like Google Analytics and Meta Pixel to understand user behavior. These tools do not identify you directly.</p>
            </div>

            <h3>7. Your Consent</h3>
            <div>
              <p>By using our site, you consent to our Privacy Policy and Terms of Use.</p>
            </div>

            <h3>8. International Users</h3>
            <div>
              <p>We comply with international data laws. Data may be processed in countries outside your residence based on server locations.</p>
            </div>

            <h3>9. Age Restrictions</h3>
            <div>
              <p>Our website is not intended for individuals under the age of 13 without parental consent.</p>
            </div>

            <h3>10. Account Deletion</h3>
            <div>
              <p>You may request to delete your account and associated data by emailing us at support@wildpawpantry.com.</p>
            </div>
          </div>
        </div>

        <div className="col-md-6">
          <div id="privacy-right">
            <h3>11. Data Retention</h3>
            <div>
              <p>We retain data as long as needed to serve you and for legal compliance. Inactive accounts may be purged after 24 months.</p>
            </div>

            <h3>12. How We Share Data</h3>
            <div>
              <p>Only with trusted partners (logistics, payment, marketing). No resale or open access to your personal information.</p>
            </div>

            <h3>13. Security Practices</h3>
            <div>
              <p>Firewalls, SSL encryption, and restricted access are implemented to protect stored data and user privacy.</p>
            </div>

            <h3>14. Policy Updates</h3>
            <div>
              <p>We may update this policy. You will be notified via email or in-app alerts when significant changes are made.</p>
            </div>

            <h3>15. Children's Privacy</h3>
            <div>
              <p>We do not knowingly collect personal data from children under 13. If discovered, we will delete the data immediately.</p>
            </div>

            <h3>16. Behavioral Advertising</h3>
            <div>
              <p>We may use collected data for targeted ads on Facebook, Google, and other platforms. You can opt out via ad settings.</p>
            </div>

            <h3>17. Data Portability</h3>
            <div>
              <p>You can request a copy of your data in a machine-readable format by contacting support.</p>
            </div>

            <h3>18. GDPR and CCPA Rights</h3>
            <div>
              <p>You have the right to access, correct, erase, or limit the use of your personal data under GDPR/CCPA rules.</p>
            </div>

            <h3>19. Contact Information</h3>
            <div>
              <p>Email us at <a href="mailto:support@wildpawpantry.com">support@wildpawpantry.com</a> for any questions or data requests.</p>
            </div>

            <h3>20. Data Breach Procedures</h3>
            <div>
              <p>In case of a data breach, we will notify affected users within 72 hours in accordance with regulatory requirements.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default PrivacyPolicy;
