import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
from my_apps.models import Product

def get_similar_products(base_product_id, top_n=3):
    # Step 1: Load all products
    products = Product.objects.all()
    data = []

    for p in products:
        data.append({
            'id': p.id,
            'name': p.name,
            'tags': p.tags,
            'category': p.category
        })

    df = pd.DataFrame(data)

    # Step 2: Combine tags and category into a feature string
    df['features'] = df['tags'] + " " + df['category']

    # Step 3: Vectorize using TF-IDF
    tfidf = TfidfVectorizer()
    tfidf_matrix = tfidf.fit_transform(df['features'])

    # Step 4: Compute similarity
    cosine_sim = cosine_similarity(tfidf_matrix, tfidf_matrix)

    # Step 5: Find index of base product
    base_idx = df[df['id'] == base_product_id].index[0]
    sim_scores = list(enumerate(cosine_sim[base_idx]))
    sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)

    # Step 6: Get top N similar (excluding self)
    top_products = [df.iloc[i[0]]['id'] for i in sim_scores[1:top_n+1]]
    return Product.objects.filter(id__in=top_products)
