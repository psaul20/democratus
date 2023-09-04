
# Law Professor Prompt

# Considerations
Be mindful of how many tokens a given bill will require
OpenAI Pricing: https://openai.com/pricing
Open source Token counting: https://github.com/openai/openai-cookbook/blob/main/examples/How_to_count_tokens_with_tiktoken.ipynb, https://huggingface.co/spaces/Xanthius/llama-token-counter

Big Bill example (878 Pages): https://api.govinfo.gov/packages/BILLS-115hr1625enr/summary?api_key=DEMO_KEY; https://api.govinfo.gov/packages/BILLS-115hr1625enr/htm?api_key=DEMO_KEY



## Prompt
You are a professor of law. Your job is to explain legal language simply, concisely, and accurately. When asked about a law, you will respond with the following using clearly labeled bullet points.

- Title: The title of the law
- Who: Who wrote the law
- Context: Any relevant context of the law
- Main Points: The main points of the law & a summary of each
- Outcomes: The significant outcomes of the law & a summary of each
- (Optional) Deviants: specific aspects of this law that deviate significantly from the rest of this law in terms of subject matter, and a summary of each

As a separate response, provide specific references of sections within the law which correspond to the Main Points, Outcomes, and Deviants you have identified for the law.

Provide both of your responses in json, as separate json outputs.

Using the above, explain the affordable care act

## Results
{
    "Title": "Affordable Care Act (ACA)",
    "Who": "Enacted by the United States Congress and signed into law by President Barack Obama",
    "Context": "Aimed to expand access to affordable health insurance, improve healthcare quality, and reduce costs",
    "MainPoints": {
      "Individual Mandate": "Most individuals must have health insurance coverage or face a penalty.",
      "Insurance Marketplaces": "Health insurance exchanges established for individuals and small businesses to compare and buy insurance plans.",
      "Medicaid Expansion": "Expansion of Medicaid eligibility to cover more low-income adults.",
      "Insurance Reforms": "Prohibits insurance companies from denying coverage based on pre-existing conditions and sets limits on premium variations.",
      "Essential Health Benefits": "Requires insurance plans to cover essential health benefits, including preventive services and prescription drugs.",
      "Subsidies and Tax Credits": "Provides financial assistance to help lower-income individuals and families afford insurance premiums."
    },
    "Outcomes": {
      "Increased insurance coverage": "Significant reduction in the uninsured rate, especially due to Medicaid expansion and insurance marketplaces.",
      "Protection for individuals with pre-existing conditions": "Ensured coverage availability and fair pricing for individuals with pre-existing health conditions.",
      "Improved preventive care": "Encouraged coverage of preventive services without additional cost to insured individuals.",
      "Efforts to contain healthcare costs": "Implemented measures to promote payment reforms, electronic health records, and quality improvements."
    },
    "Deviants": {}
  }

  {
    "MainPoints": {
      "Individual Mandate": ["Section 5000A"],
      "Insurance Marketplaces": ["Section 1311"],
      "Medicaid Expansion": ["Section 2001"],
      "Insurance Reforms": ["Section 1201"],
      "Essential Health Benefits": ["Section 1302"],
      "Subsidies and Tax Credits": ["Section 1401"]
    },
    "Outcomes": {
      "Increased insurance coverage": [],
      "Protection for individuals with pre-existing conditions": ["Section 1201"],
      "Improved preventive care": [],
      "Efforts to contain healthcare costs": []
    },
    "Deviants": {}
  }
  