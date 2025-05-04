// src/components/FAQ.js
import React, { useEffect } from 'react';
import $ from 'jquery';
import 'jquery-ui/ui/widgets/accordion';
import 'jquery-ui/themes/base/all.css';
import './css/FAQ.css';

const FAQ = () => {
  useEffect(() => {
    $("#accordion-left, #accordion-right").accordion({
      collapsible: true,
      heightStyle: "content"
    });
  }, []);

  return (
    <div className="container faq-section">
      <h2 className="text-center mb-4">Frequently Asked Questions <img src="/media/images/parakeet.png" alt="Parakeet" className="parakeet" /></h2>
      <div className="row">
        <div className="col-md-6">
          <div id="accordion-left">
            <h3>Where do your jerky meats come from?</h3>
            <div><p>We ethically source jerky and wild meats from Australian feral animal management programs.</p></div>

            <h3>Is your dog food suitable for omnivores?</h3>
            <div><p>Yes, it includes meats, grains, and supplements for a balanced omnivore diet.</p></div>

            <h3>What are whole prey meals?</h3>
            <div><p>Whole prey meals include organs, bones, and meat to mimic natural diets.</p></div>

            <h3>Is cat food suitable for ferrets?</h3>
            <div><p>Some high-protein cat foods may suit ferrets, but we offer species-specific ferret formulas.</p></div>

            <h3>What exotic animals do you make food for?</h3>
            <div><p>We cater to hedgehogs, fennec foxes, Asian small-clawed otters, mini pigs, sugar gliders, parrots, toucans, meerkats, capybaras, kinkajous, and marmosets.</p></div>

            <h3>Do you use slaughterhouse waste?</h3>
            <div><p>Yes, we repurpose inspected by-products into animal feed pellets.</p></div>

            <h3>What is the shelf life of dried forage?</h3>
            <div><p>Up to 12 months if stored in a cool, dry place.</p></div>

            <h3>What exotic meats are used?</h3>
            <div><p>We use camel, goat, crocodile, buffalo, kangaroo, quail, mice, emu, and wild pig. All are disease-free and inspected in Australia.</p></div>

            <h3>Are your grains and hay locally sourced?</h3>
            <div><p>Yes, all grains, hay, and carp meal are sourced from the USA.</p></div>

            <h3>Do you offer species-specific pellet options?</h3>
            <div><p>Yes, each pellet formula is tailored to the dietary needs of the specific animal species.</p></div>
          </div>
        </div>

        <div className="col-md-6">
          <div id="accordion-right">
            <h3>Do you offer hypoallergenic options?</h3>
            <div><p>Yes, we offer single-protein and grain-free formulas.</p></div>

            <h3>How do I transition my pet to your food?</h3>
            <div><p>Start with 25% new food, increasing over 7–10 days.</p></div>

            <h3>Do you ship internationally?</h3>
            <div><p>Currently within the USA, but we plan to expand.</p></div>

            <h3>Are your ingredients organic?</h3>
            <div><p>Some products are organic. Look for certification on labels.</p></div>

            <h3>Do you use preservatives?</h3>
            <div><p>Only natural preservatives like tocopherols and citric acid.</p></div>

            <h3>Can cats eat dog food?</h3>
            <div><p>No, cats are obligate carnivores and need taurine-rich cat food.</p></div>

            <h3>Are your products vet-approved?</h3>
            <div><p>Formulas are developed with expert consultation and lab testing.</p></div>

            <h3>Do you offer sample packs?</h3>
            <div><p>Yes, small trial packs are available for most items.</p></div>

            <h3>What packaging sizes are available?</h3>
            <div><p>500g trial, 2kg, 5kg, and 10kg bulk sizes.</p></div>

            <h3>How do I contact support?</h3>
            <div><p>Email us at support@wildpawpantry.com or call during business hours.</p></div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default FAQ;