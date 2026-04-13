<!-- 이 문서는 영어 위키백과 'Wikipedia:Signs of AI writing' 문서의 한국어 번역본입니다. 원본은 CC BY-SA 4.0 라이선스입니다. -->

# 위키백과: AI 글쓰기의 징후

*"Wikipedia:AI writing"은 여기로 리다이렉트됩니다. 다른 용도는 WP:AI-INDEX를 참조하십시오.*

*이 문서는 위키프로젝트 AI 정리(WikiProject AI Cleanup)의 조언 문서입니다.*
*이 문서는 커뮤니티 검토를 거치지 않았으므로 위키백과 정책이 아닙니다.*

이 문서는 ChatGPT 같은 AI 챗봇에서 흔히 나타나는 글쓰기 및 서식 관행의 목록으로, 위키백과 문서와 초안에서 가져온 실제 사례를 포함하고 있습니다. 위키백과에서 공개되지 않은 AI 생성 콘텐츠를 탐지하는 데 도움이 되는 현장 안내서입니다. 일부 징후는 넓은 범위에 적용될 수 있지만, 위키백과가 아닌 맥락에서는 적용되지 않을 수도 있습니다.[a] 이러한 지표가 나타나는 모든 글이 AI 생성인 것은 아닙니다. AI 챗봇을 구동하는 대규모 언어 모델은 위키백과를 포함한 인간의 글쓰기를 학습 데이터로 사용하기 때문입니다. AI 글쓰기의 많은 요소는 사설, 블로그, 팬픽션에서도 발견됩니다.

또한, 이 목록은 기술적(descriptive)이지 규범적(prescriptive)이지 않습니다. 관찰 결과이지 규칙이 아닙니다. 피해야 할 서식이나 언어에 대한 조언은 정책과 지침, 편집 지침서(Manual of Style)에서 찾을 수 있으나, 이 문서에는 해당하지 않습니다.

여기서 다루는 패턴들은 문제 자체가 아니라 문제의 잠재적 징후일 뿐입니다. 이러한 문제 중 다수는 즉시 눈에 띄고 쉽게 수정할 수 있지만---예를 들어 과도한 굵은 글씨, 깨진 마크업, 인용 스타일의 특이점---이것들은 겉으로는 잘 보이지 않지만 훨씬 더 심각한 정책적 위험을 수반하는 문제들을 가리킬 수 있습니다. 이러한 징후를 수정해야 할 문제 자체로 취급하지 마십시오. 그렇게 하면 오히려 탐지가 어려워질 수 있습니다. 실제 문제는 그 이면에 있는 더 깊은 우려 사항이므로, Wikipedia:Large language models -- Handling suspected LLM-generated content 및 Wikipedia:WikiProject AI Cleanup/Guide의 조언에 따라 직접 해결하거나 신고하시기 바랍니다.

즉시 삭제 정책 기준 G15(인간 검토 없는 LLM 생성 문서)에는 일부 AI 글쓰기 징후가 나열되어 있으나, 가장 객관적인 것들로 제한됩니다. 여기서 다루는 나머지 징후들만으로는 즉시 삭제에 충분하지 않습니다.

## 주의 사항

### AI 탐지 도구

AI 콘텐츠 탐지 도구(GPTZero 등)에만 의존하지 마십시오. 이러한 도구들은 무작위 확률보다는 나은 성능을 보이지만 무시할 수 없는 오류율을 가지고 있습니다.[1] 탐지기는 텍스트 수정(예: 의역, 마크업, 간격 변경)이나 훈련 중 접하지 못한 모델의 사용 같은 요인에 취약할 수 있습니다.[2]

### 자신의 탐지 능력

*Wikipedia:AI or not quiz에서 AI 탐지 능력을 테스트해 보십시오.*

자신의 판단에 지나치게 의존하지 마십시오. AI 생성 텍스트를 탐지하는 인간의 능력에 관한 연구는 제한적이지만, 2025년 프리프린트에 따르면 LLM을 많이 사용하는 사람들은 문서가 AI에 의해 생성되었는지 약 90%의 정확도로 판별할 수 있습니다. 이는 LLM 전문 사용자가 10개 문서를 AI 생성으로 태그하면 아마 한 건은 거짓 양성(false positive)이라는 뜻입니다. LLM을 많이 사용하지 않는 사람들은 (양쪽 방향 모두에서) 무작위 확률보다 약간 나은 수준에 그칩니다.[1]

또한, 필자들이 AI 사용 의심을 피하기 위해 글쓰기 행동을 조정하거나, AI 특유의 표현 사용에 대해 방어적일 수 있다는 점도 주목할 만합니다.

## 콘텐츠

LLM(그리고 일반적으로 인공 신경망)은 대규모 학습 자료를 기반으로 다음에 올 내용을 추측(추론)하는 통계적 알고리즘을 사용합니다. 따라서 통계적 평균으로의 회귀(regression to the mean) 경향이 있습니다. 즉, 결과가 가장 광범위한 경우에 적용될 수 있는 통계적으로 가장 가능성 높은 결과로 수렴하는 경향이 있습니다. 이것은 동시에 강점이자 AI 생성 콘텐츠를 탐지하는 "단서"가 됩니다.

예를 들어, LLM은 주로 인터넷 데이터로 훈련되는데, 인터넷에서 유명인은 대체로 긍정적이고 중요하게 들리는 언어로 묘사됩니다. 결과적으로 LLM은 구체적이고 독특하며 뉘앙스 있는 사실(통계적으로 드문 것)을 생략하고 더 일반적이고 긍정적인 묘사(통계적으로 흔한 것)로 대체하는 경향이 있습니다. 그래서 매우 구체적인 "최초의 열차 연결 장치 발명자"가 "혁명적인 산업계의 거인"으로 바뀔 수 있습니다. 이는 초상화가 선명한 사진에서 흐릿하고 평범한 스케치로 점점 변해 가면서도, 그 초상화가 유일무이한 중요 인물을 보여준다고 점점 더 크게 외치는 것과 같습니다. 대상은 동시에 덜 구체적이면서 더 과장되어 갑니다.[b]

이러한 통계적 평균으로의 회귀---구체적 사실이 여러 주제에 동등하게 적용될 수 있는 일반적 진술로 평활화되는 현상---는 AI 생성 콘텐츠의 탐지를 더 쉽게 만듭니다.

더불어, 각 AI 챗봇의 모델과 버전은 고유한 문체(개인어, idiolect)를 가지고 있어,[3] GPT-4에 전형적인 특성이 Gemini에는 해당하지 않을 수 있습니다.

### 중요성, 유산, 광범위한 동향에 대한 과도한 강조

**주의할 단어:** stands/serves as, is a testament/reminder, a vital/significant/crucial/pivotal/key role/moment, underscores/highlights its importance/significance, reflects broader, symbolizing its ongoing/enduring/lasting, contributing to the, setting the stage for, marking/shaping the, represents/marks a shift, key turning point, evolving landscape, focal point, indelible mark, deeply rooted, ...

LLM 글쓰기는 주제의 임의적 측면이 더 넓은 주제를 대표하거나 기여한다는 진술을 추가함으로써 해당 주제의 중요성을 부풀리는 경향이 있습니다.[4] 이러한 진술을 작성하는 방식에는 뚜렷하고 쉽게 식별할 수 있는 레퍼토리가 있습니다.[5]

> The Statistical Institute of Catalonia was officially established in 1989, marking a pivotal moment in the evolution of regional statistics in Spain. [...] The founding of Idescat represented a significant shift toward regional statistical independence, enabling Catalonia to develop a statistical system tailored to its unique socio-economic context. This initiative was part of a broader movement across Spain to decentralize administrative functions and enhance regional governance.
>
> --- Statistical Institute of Catalonia 문서의 해당 편집에서 발췌

> Kumba has long been an important center for trade and agriculture. [...] The establishment of road networks connecting Kumba to other parts of the Southwest Region, such as Mamfe and Buea, helped solidify its role as a regional hub.
>
> --- Kumba, Cameroon 문서의 해당 편집에서 발췌

LLM은 어원이나 인구 데이터 같은 가장 평범한 주제에 대해서도 이런 진술을 포함할 수 있습니다. 때로는 주제가 상대적으로 덜 중요하거나 주목도가 낮다는 것을 인정하는 완곡한 서문을 붙인 뒤, 그럼에도 불구하고 그 중요성에 대해 이야기합니다.

#### 예시

> During the Spanish colonial period, the name Bakunutan was hispanized to Bacnotan, a modification reflected in official documents preserved in the National Archives in Manila. This etymology highlights the enduring legacy of the community's resistance and the transformative power of unity in shaping its identity.
>
> --- Bacnotan 문서의 해당 편집에서 발췌

> Though it saw only limited application, it contributes to the broader history of early aviation engineering and reflects the influence of French rotary designs on German manufacturers.
>
> --- Draft:Goebel Goe II 문서에서 발췌

생물학에 관해 글을 쓸 때(예: 동물이나 식물 종에 대해 논의할 때), LLM은 그 연결이 미약하거나 일반적인 경우에도 더 넓은 생태계나 환경과의 연결을 과도하게 강조하는 경향이 있습니다. 또한 보전 상태가 알려지지 않았거나 실질적인 노력이 존재하지 않더라도 해당 종의 보전 상태와 연구 및 보존 노력을 장황하게 서술하는 경향이 있습니다.

#### 예시

> It plays a role in the ecosystem and contributes to Hawaii's rich cultural heritage. [...] Preserving this endemic species is vital not only for ecological diversity but also for sustaining the cultural traditions connected to Hawaii's native flora.
>
> --- Nototrichium divaricatum 문서의 해당 편집에서 발췌

> Currently, there is no specific conservation assessment for Lethrinops lethrinus by the International Union for Conservation of Nature (IUCN). However, the general health of the Lake Malawi ecosystem is crucial for the survival of this and other endemic species. Factors such as overfishing, pollution, and habitat destruction could potentially impact their populations.
>
> --- Lethrinops lethrinus 문서의 해당 편집에서 발췌

### 주목도, 출처 귀속, 미디어 보도에 대한 과도한 강조

**주의할 단어:** independent coverage, local/regional/national/[country name] media outlets, music/business/tech outlets, profiled in, written by a leading expert, active social media presence

마찬가지로, LLM은 주제의 주목도를 증명하는 최선의 방법이 주목도에 대한 주장으로 독자를 압도하는 것인 양 행동하며, 주로 해당 주제가 보도된 출처를 나열합니다. 그러한 출처들이 실제로 주제에 대해 무엇을 말했는지에 대한 추가 맥락을 제공할 수도, 제공하지 않을 수도 있으며, 자신의 피상적 분석을 출처에 부정확하게 귀속시키는 경우가 많습니다. 이는 더 최근의 AI 도구(2025년 이후)에서 생성된 텍스트에서 더 흔합니다.

물론 인간이 작성한 보도자료도 수십 년간 뉴스 스크랩을 인용해 왔지만, 위키백과 문서 작성을 특별히 요청받은 LLM은 "independent coverage(독립적 보도)"와 같은 위키백과 지침의 정확한 문구를 그대로 사용하는 경우가 많습니다.

#### 예시

> She spoke about AI on CNN, and was featured in Vogue, Wired, Toronto Star, and other media. [...] Her insights have also been featured in *Wired*, *Refinery29*, and other prominent media outlets.
>
> --- Sinead Bovell 문서의 해당 편집에서 발췌 (마크다운 사용에도 주목)

> Her views have been cited in The New York Times, BBC, Financial Times, and The Hindu.
>
> --- Shamika Ravi 문서의 해당 편집에서 발췌

> Its significance is documented in archived school event programs and regional press coverage, including the *Mesabi Daily News*, which regularly reviewed performances held there.
>
> --- Virginia High School (Minnesota) 문서의 해당 편집에서 발췌 (마크다운 사용에도 주목)

위키백과에서 특히 LLM은 사소한 보도, 논쟁의 여지가 없는 사실, 또는 인간 위키백과 편집자라면 인라인 인용이나 아예 출처 없이 처리했을 상황에서도 본문에서 출처를 세심하게 강조하는 경향이 있습니다.

#### 예시

> The restaurant has also been mentioned in ABC News coverage relating to incidents in the surrounding precinct, underscoring its role as a well-known late-night venue in the city [of Adelaide].
>
> --- The Original Pancake Kitchen 문서의 해당 편집에서 발췌. 출처 귀속이 포함된 사소한 보도; 이 문장에 추가된 참고문헌은 실존하지 않았음.

> In the United States, university-based incubators and accelerators have expanded alongside these centers; an official Library of Congress review found that 31.5% of SBA [Small Business Administration] Growth Accelerator Fund Competition winners from 2014--2016 were university-based programs.
>
> --- Entrepreneurship education 문서의 해당 편집에서 발췌. 논쟁의 여지가 없는 정보에 대한 출처 귀속.

소셜 미디어를 사용하는 인물이나 단체에 관한 문서에서 LLM은 그들이 "활발한 소셜 미디어 존재감을 유지한다(maintain an active social media presence)"거나 비슷한 표현을 자주 사용합니다. 이 표현은 AI 텍스트에 특히 고유한 것으로, 2024년 이전 위키백과에서는 비교적 드물었습니다.

> The mall maintains a strong digital presence, particularly on Instagram, where it actively shares the latest updates and events. Forum Kochi has consistently demonstrated excellence in digital promotions, with high-quality, engaging, and impactful video content playing a key role in its outreach.
>
> --- Forum Mall Kochi 문서의 해당 편집에서 발췌

일부 경우, LLM은 주목도를 주장하기 위한 별도의 섹션을 만들어 해당 주제를 다룬 출처를 목록 형식으로 분류합니다. 이는 대부분의 문서가 작성되는 방식---출처가 발행한 내용을 요약한 후 각주로 인용하는 방식---과 대조적입니다.

#### 예시

> Media coverage
>
> **IRNA** -- Coverage of his inter-city marathon events.
> **ISNA** -- Report on an 80 km provincial peace run.
> **IFRC** -- Feature on his humanitarian campaigns.
> **Fars News** -- Interview on his national running projects.
> **Varzesh3** -- Report on a 17-day endurance run.
> **Borna News** -- Profile on his athletic background.
>
> --- Draft:Mojtaba Yadegari (Iranian runner) 문서의 이전 버전에서 발췌

### 피상적 분석

**주의할 단어:** highlighting/underscoring/emphasizing ..., ensuring ..., reflecting/symbolizing ..., contributing to ..., cultivating/fostering ..., encompassing ..., valuable insights, align/resonate with,

AI 챗봇은 정보에 대한 피상적 분석을 삽입하는 경향이 있으며, 이는 종종 중요성, 인지도, 또는 영향력과 관련됩니다.[6] 이는 흔히 문장 끝에 현재분사("-ing") 구문을 붙이는 방식으로 이루어지며, 때로는 제3자에 대한 모호한 귀속과 함께 사용됩니다(아래 참조).[6][4]

위키백과의 관점에서 이러한 논평은 대개 독자적 종합(synthesis) 및/또는 출처 없는 의견에 해당합니다. 검색 증강 생성(retrieval-augmented generation)을 갖춘 최신 챗봇(예: 웹 검색이 가능한 AI 챗봇)은 이러한 진술을 명명된 출처에 붙일 수 있습니다---예를 들어, "로저 이버트는 지속적인 영향력을 강조했다"---해당 출처가 그와 비슷한 말을 했는지 여부와 관계없이.

#### 예시

> As of the April 2008 census, the population of Douera stood at approximately 56,998 inhabitants, creating a lively community within its borders. Situated in the central-north region of the country, Douera enjoys close proximity to the capital city, Algiers, further enhancing its significance as a dynamic hub of activity and culture. With its coastal charm and convenient location, Douera captivates both residents and visitors alike, offering a diverse range of experiences against the backdrop of Algeria's stunning natural beauty.
>
> --- Douera 문서의 해당 편집에서 발췌

> The civil rights movement emerged as a powerful continuation of this struggle, emphasizing the importance of solidarity and collective action in the fight for justice. This historical legacy has influenced contemporary African-American families, shaping their values, community structures, and approaches to political engagement. Economically, the enduring impacts of systemic inequality have led to both challenges and innovations within African-American communities, driving a commitment to empowerment and social change that echoes through generations.
>
> --- African-American culture 문서의 해당 편집에서 발췌

> Situated just a few miles from the U.S.-Mexico border---a line that often represents separation and division---the temple stands as a counter-symbol, emphasizing unity, togetherness, and transcendent faith. In a region where many families and communities span both countries, the temple fosters a sense of connection and shared purpose. Through its inclusive design and symbolic features, the McAllen Texas Temple is seen as a bridge across divides, embodying the spirit of unity that underlies its sacred purpose. Its bilingual monument sign, with inscriptions in both English and Spanish, underscores its role in bringing together Latter-day Saints from the United States and Mexico.
>
> The temple's architectural and decorative elements are thoughtfully imbued with local symbolism, reflecting the rich culture and landscape of the Rio Grande Valley. Citrus blossom motifs, seen throughout the exterior and interior, celebrate the area's agricultural roots and its vital citrus industry. The temple's color palette of blue, green, and gold resonates with the region's natural beauty, symbolizing Texas bluebonnets, the Gulf of Mexico, and the diverse Texan landscapes. These colors and patterns evoke enduring faith and resilience, qualities that resonate deeply within this close-knit, cross-border community.
>
> In design and structure, the McAllen Texas Temple honors the Spanish colonial heritage that has historically shaped the area. By incorporating these architectural elements, the temple connects to both the Latin American influences and the historic roots of the border region, creating a space where the past and present come together.
>
> --- McAllen Texas Temple 문서의 해당 편집에서 발췌

> These works are now part of the **Collections of the National Museum of Education - Reseau Canope (France)**, highlighting their historical and pedagogical significance. His influence persists in more recent studies. In 2010, Les neologismes dans l'hebdomadaire L'Express (1980) was cited in the Proceedings of the 1st International Congress on Neology in Romance Languages [...] demonstrating the ongoing relevance of his research on lexical evolution. [...] In 2004, the Cahiers de lexicologie (issues 84-87), published by the CNRS, cited the Grammaire Blois, confirming its relevance in modern research. [...]
>
> These citations, spanning more than six decades and appearing in recognized academic publications, illustrate Blois' lasting influence in computational linguistics, grammar, and neology.
>
> Fridrichova analyzes the distinction made by Blois and Bar between acronyms, abbreviations, and truncations, emphasizing their critical view on the impact of truncations in the French language. She cites Blois and Bar (1975):
>
> [...]
>
> Fridrichova highlights that Blois and Bar perceive truncations as a **distortion of the language rather than an enrichment**, a perspective that still fuels linguistic debates today. This citation demonstrates the **enduring relevance of Blois's work in modern linguistic studies** and its **critical reception by researchers**.
>
> --- Draft:Jacques Blois (linguist) 문서의 해당 편집에서 발췌. 위와 아래 문단에서도 마크다운이 사용됨.

> It holds a pivotal place in the East Central Railway Zone of Indian Railways, serving as a major railway hub with historical significance. The station has 1,676 mm (5 ft 6 in) broad gauge along with 8 tracks and 6 platforms. [...] Historically, it has been crucial for linking Darbhanga with significant cities like Delhi, Patna, and Kolkata, facilitating the movement of passengers and goods. The station has supported various services, including passenger trains and express trains like the Satyagrah Express and Mithila Express, contributing to the socio-economic development of the region. [...] Over the years, Darbhanga Junction has seen several upgrades and modernization efforts aimed at improving facilities and operational efficiency, reflecting its continued relevance in the regional and national transportation landscape.
>
> --- Darbhanga Junction railway station 문서의 해당 편집에서 발췌

### 홍보성 및 광고성 언어

*AI와 무관한 일반적 지침은 Wikipedia:Manual of Style/Words to watch -- Puffery를 참조하십시오.*

*참조: Wikipedia:Marketing buzzspeak -- Artificial intelligence and marketing buzzspeak*

**주의할 단어:** boasts a, vibrant, rich, profound, enhancing, showcasing, exemplifies, commitment to, natural beauty, nestled, in the heart of, groundbreaking, renowned, featuring, diverse array, ...

LLM은 중립적 어조를 유지하는 데 심각한 문제가 있습니다. 백과사전적 어조를 사용하라는 프롬프트를 받았을 때도, 편집자가 해당 주제에 홍보적 이해관계가 없을 때도, 출력물은 광고성 글쓰기나 여행 안내서와 유사한 문체로 흐르는 경향이 있습니다. 이는 새로운 텍스트를 생성할 때나 기존 텍스트를 재작성할 때 모두 발생할 수 있으며, 홍보성 언어를 제거했다고 주장하면서 오히려 삽입하는 경우도 있습니다.

참고: 모든 홍보성 또는 스팸성 글쓰기가 AI 생성인 것은 아닙니다. LLM은 주제와 관계없이 동일한 홍보성 표현 세트를 과다 사용하는 경향이 있습니다. 또한 구세대 LLM(예: GPT-4)은 노골적으로 긍정적인 텍스트를 출력하는 경향이 있고, 최신 LLM은 은근하게 긍정적일 가능성이 더 높습니다.

#### 하위 유형

"문화유산"으로 간주될 수 있는 것(일본의 전자 산업까지 포함하여)에 대해 글을 쓸 때, LLM은 그 중요성을 독자에게 끊임없이 상기시킵니다.

> Nestled within the breathtaking region of Gonder in Ethiopia, Alamata Raya Kobo stands as a vibrant town with a rich cultural heritage and a significant place within the Amhara region. From its scenic landscapes to its historical landmarks, Alamata Raya Kobo offers visitors a fascinating glimpse into the diverse tapestry of Ethiopia. In this article, we will explore the unique characteristics that make Alamata Raya Kobo a town worth visiting and shed light on its significance within the Amhara region.
>
> --- Alamata (woreda) 문서의 해당 편집에서 발췌

> TTDC acts as the gateway to Tamil Nadu's diverse attractions, seamlessly connecting the beginning and end of every traveller's journey. It offers dependable, value-driven experiences that showcase the state's rich history, spiritual heritage, and natural beauty.
>
> --- Tamil Nadu Tourism Development Corporation 문서의 해당 편집에서 발췌

인물이나 기업에 대해 글을 쓸 때, LLM은 보도자료나 광고와 유사한 어조를 자주 채택합니다.

> These projects align with KQ's goals of reducing its environmental footprint, improving operational efficiency, and fostering community development through job creation. CEO Allan Kilavuka emphasized the airline's commitment to sustainability, customer focus, and Africa's prosperity through responsible corporate practices.
>
> --- Kenya Airways 문서의 해당 편집에서 발췌; 복수의 피상적 분석에 주목

> The SOLLEI's exterior design communicates a powerful emotional presence, staying true to Cadillac's signature bold proportions. Its low, elongated silhouette is highlighted by a wide stance and an extended coupe door, which enhances accessibility to the spacious rear cabin. Smooth, uninterrupted surfaces and a pronounced A-line accentuate the vehicle's overall length, while a sleek, low tail imparts a sense of refined dynamism. A mid-body line runs seamlessly from the headlamps to the taillights, reinforcing the car's cohesive and elegant design. Traditional door handles have been replaced with discrete buttons, preserving the vehicle's clean and modern profile. In a nod to Cadillac's legacy of bold color choices, the exterior is finished in "Manila Cream"---a distinctive hue originally offered in 1957 and 1958. This heritage color has been thoughtfully revived and hand-painted by Cadillac artisans, showcasing the brand's dedication to craftsmanship and historical reverence.
>
> --- Cadillac Sollei 문서의 해당 편집에서 발췌

### 모호한 귀속과 의견의 과잉 일반화

*AI와 무관한 일반적 지침은 Wikipedia:Manual of Style/Words to watch -- Unsupported attributions를 참조하십시오.*

**주의할 단어:** Industry reports, Observers have cited, Experts argue, Some critics argue, several sources/publications (when only few sources are cited), such as (before exhaustive word lists), ...

AI 챗봇은 의견이나 주장을 모호한 권위에 귀속시키는 경향이 있으며, 이를 족제비 표현(weasel wording)이라 합니다.

#### 예시

> Due to its unique characteristics, the Haolai River is of interest to researchers and conservationists. Efforts are ongoing to monitor its ecological health and preserve the surrounding grassland environment, which is part of a larger initiative to protect China's semi-arid ecosystems from degradation.
>
> --- Haolai River 문서의 해당 편집에서 발췌

> The Kwararafa (Kororofa) confederacy is described in scholarship as a shifting Benue valley coalition led by Jukun groups and incorporating a range of Middle Belt peoples. Because much of the historical record derives from Hausa chronicles, Bornu sources and oral tradition, modern researchers treat Kwararafa as a fluid political and cultural formation rather than a fixed state.
>
> --- Kwararafa Confederacy 문서의 해당 편집에서 발췌

AI 챗봇은 또한 이러한 의견이 귀속되는 출처의 수를 과장하는 것이 일반적입니다. 하나 또는 두 개의 출처에서 나온 견해를 널리 공유되는 것처럼 제시하거나(종종 위의 모호한 귀속과 결합하여), 한 사람만 인용하면서 여러 "평론가" 또는 "학자"의 존재나 의견을 언급하거나, 출처에서 다른 사례가 존재한다는 표시가 없는데도 예시 목록이 비제한적(non-exhaustive)인 것처럼 암시할 수 있습니다.

#### 예시

> The band's rise has often centered on Zardoya's bilingual lyrics and cultural background, which several publications have cited as "bridging worlds through music."[overgen 1][overgen 2]
>
> --- Maria Zardoya 문서에서 발췌

> Toy industry publications such as The Toy Insider and Mojo Nation have presented Rubik's WOWCube as a STEM-oriented platform that brings the Rubik's Cube "into the future" with motion controls and an open software ecosystem.[overgen 3][overgen 4]
>
> --- Rubik's WOWCube 문서에서 발췌

**참고문헌**

1. Rodriguez, Suzy Exposito (August 29, 2024). "Maria Zardoya, of the Marias, chooses to relive her breakup every night". *Los Angeles Times*. Retrieved December 5, 2025.
2. Lopez, Julyssa (September 12, 2024). "Maria Zardoya Is Bridging Worlds Through Music". *Time Magazine*. Retrieved December 5, 2025.
3. "Rubik's WOWCube". *The Toy Insider*. October 31, 2025. Retrieved December 2, 2025.
4. "Cubios Inc teams with Spin Master for Rubik's WOWCube gaming platform". *Mojo Nation*. July 26, 2025. Retrieved December 2, 2025.

### 도전과 미래 전망에 대한 개요식 결론

**주의할 단어:** Despite its... faces several challenges..., Despite these challenges, Challenges and Legacy, Future Outlook ...

많은 LLM 생성 위키백과 문서에는 "도전(Challenges)" 섹션이 포함되어 있으며, 일반적으로 "그 [긍정적/홍보적 단어]에도 불구하고, [문서 주제]는 도전에 직면하고 있다..."와 같은 문장으로 시작하여, 문서 주제에 대한 막연히 긍정적인 평가[1]로 끝나거나, 진행 중이거나 잠재적인 이니셔티브가 주제에 도움이 될 수 있다는 추측으로 끝납니다. 이러한 문단은 보통 경직된 개요 구조를 가진 문서의 끝부분에 나타나며, "미래 전망(Future Prospects)"을 위한 별도 섹션을 포함할 수도 있습니다.

참고: 이 징후는 경직된 공식에 관한 것이지, 단순히 도전이나 어려움을 언급하는 것에 관한 것이 아닙니다.

#### 예시

> Despite its industrial and residential prosperity, Korattur faces challenges typical of urban areas, including [...] With its strategic location and ongoing initiatives, Korattur continues to thrive as an integral part of the Ambattur industrial zone, embodying the synergy between industry and residential living.
>
> --- Korattur 문서의 해당 편집에서 발췌

> Despite its success, the Panama Canal faces challenges, including [...] Future investments in technology, such as automated navigation systems, and potential further expansions could enhance the canal's efficiency and maintain its relevance in global trade.
>
> --- Panama Canal 문서의 해당 편집에서 발췌

> Despite their promising applications, pyroelectric materials face several challenges that must be addressed for broader adoption. One key limitation is [...] Despite these challenges, the versatility of pyroelectric materials positions them as critical components for sustainable energy solutions and next-generation sensor technologies.
>
> --- Pyroelectricity 문서의 해당 편집에서 발췌

> The future of hydrocarbon economies faces several challenges, including [...] This section would speculate on potential developments and the changing landscape of global energy.
>
> --- Hydrocarbon economy 문서의 해당 편집에서 발췌

> Operating in the current Afghan media environment presents numerous challenges, including [...] Despite these challenges, Amu TV has managed to continue to provide a vital service to the Afghan population.
>
> --- Amu Television 문서의 해당 편집에서 발췌

> For example, while the methodology supports transdisciplinary collaboration in principle, applying it effectively in large, heterogeneous teams can be challenging. [...] SCE continues to evolve in response to these challenges.
>
> --- Draft:Socio-cognitive engineering 문서의 해당 편집에서 발췌

> Challenges and Future Directions
>
> As the global economy continues to evolve, international economic law faces new challenges and opportunities. [...] The future of international economic law lies in its ability to adapt to these emerging trends and continue to facilitate a stable and equitable global economic order.
>
> --- International economic law 문서의 해당 편집에서 발췌

### 위키백과 목록이나 광범위한 문서 제목을 고유명사처럼 취급하는 서두

목록처럼 고유명이 아닌 제목을 가진 주제에 대한 AI 생성 문서에서, 서두의 첫 문장이 문서 제목을 마치 독립적인 현실 세계의 실체인 것처럼 소개하거나 정의하는 경우가 있습니다. 편집 지침서에서는 이러한 제목을 서두 시작 부분에 "자연스러운 방식으로" 포함할 수 있도록 허용하고 있지만, AI가 작성한 서두는 그다지 자연스럽지 않은 경향이 있습니다.

#### 예시

> **Catchment area (health)** refers to the geographic area from which a health facility, such as a hospital or clinic, draws its patients.
>
> --- 현재 삭제된 Catchment area (health) 문서의 해당 편집에서 발췌

> **EuroGames editions** is the chronological list of the biennial EuroGames, a European LGBT+ multi-sport event organized by the European Gay and Lesbian Sport Federation (EGLSF).
>
> --- EuroGames editions 문서의 해당 편집에서 발췌

> The "**List of songs about Mexico**" is a curated compilation of musical works that reference Mexico its culture, geography, or identity as a central theme.
>
> --- List of songs about Mexico 문서의 해당 편집에서 발췌

### 존재하지 않는 바로가기

몇몇 경우, AI 챗봇 사용자들이 토론에 참여하면서 기존 문서로 리다이렉트되지 않는 환각된(hallucinated) 바로가기가 포함된 텍스트를 붙여넣은 사례가 있습니다.

#### 예시

> Annu Gaidhu's work exists at the intersection of trauma-informed yoga, diasporic South Asian identity, and youth empowerment. These are areas often underrepresented on Wikipedia. As per WP:NOTABILITY and WP:NOTELOCAL, niche figures can still be notable if they receive significant coverage within the reliable sources of that niche.
>
> The subject's career bridges media, child and youth care scholarship, trauma-informed wellness, and international yoga education. This makes her notable within multiple domains, not solely for pageantry. Deletion removes a rare example of a South Asian Canadian woman working at the intersection of care, academia, and arts --- a key equity concern per WP:UNDERREP and WP:BIAS and relevant WikiProjects.
>
> --- Wikipedia:Articles for deletion/Annu Gaidhu에서 발췌; 첫 번째는 굵은 글씨를 오용하고 있으며, 두 항목 모두 삼의 법칙(rule of three)을 보여줌

> Respectfully noted. However, engaging with arguments presented in a deletion discussion is entirely within the bounds of WP:AFDPURPOSE. This is not "bludgeoning," it's addressing flawed logic and misapplications of policy. If a "keep" !vote contains reasoning based on a misinterpretation of WP:BLP1E or WP:NPERSON, it should be scrutinized. That's how consensus is built --- through critical analysis, not silence
>
> --- Wikipedia:Articles for deletion/Lilly Contino 문서의 해당 편집에서 발췌; 이 텍스트에는 부정 병렬 구문, 둥근 따옴표와 아포스트로피, 그리고 엠 대시도 포함되어 있음

> Verification over Origin (WP:V & WP:NOTAI): AI-assisted drafting is not prohibited. Per Wikipedia policy, the focus is on verifiability, not the tool used for drafting.
>
> --- Talk:Arthur Katalayi 문서의 해당 편집에서 발췌; 이것은 목록 항목의 일부이기도 함

## 언어와 문법

### 높은 빈도의 "AI 어휘" 단어

**주의할 단어:** Additionally, (특히 문장 시작에서),[7] align with,[5][8] boasts ("has"의 의미로),[9] bolstered,[8] crucial,[1][7] delve,[5][8][1][10] emphasizing,[5][8] enduring,[8] enhance,[8][1] fostering,[8][1] garner,[5][8] highlight (동사로),[1][10] interplay,[8] intricate/intricacies,[5][8][6][10] key (형용사로), landscape (추상 명사로),[1] meticulous/meticulously,[9][8] pivotal,[8][1] showcase,[5][8][10] tapestry (추상 명사로),[1][6][10] testament,[1] underscore (동사로),[5][8][1][10] valuable,[7] vibrant[6]

다수의 연구에서 LLM이 특정 단어를 과도하게 사용한다는 사실이 입증되었다. 이러한 단어들은 LLM 챗봇이 널리 보급된 2022년 이후 생성된 텍스트에서 이전 유사 텍스트보다 훨씬 높은 빈도로 등장하기 시작했다.[5][8] 이 단어들은 LLM 출력에서 함께 나타나는 경향이 있어, 하나가 보이면 다른 것들도 함께 있을 가능성이 높다.[11] 이들 연구 대부분은 학술 초록이나 소설을 분석했지만, "AI 어휘" 단어는 Grokipedia 같은 LLM 기반 백과사전과 AI가 생성한 위키백과 텍스트에서도 편재한다. 편집에서 이런 단어가 한두 개 나타나는 것은 우연일 수 있지만, (2022년 이후) 편집에서 이런 단어가 여러 개, 여러 번 등장한다면 이는 AI 사용의 가장 강력한 징후 중 하나이다.

"AI 어휘"의 분포는 어떤 챗봇이나 LLM을 사용했는지에 따라 약간 다르며,[6] 시간이 지남에 따라 변화해 왔다. 예를 들어, *delve*라는 단어는 2023년과 2024년 초에 ChatGPT에서 유명하게 과도하게 사용되었지만, 2024년 후반에는 빈도가 줄었고 2025년에는 급격히 감소했다.[12][7] 아래는 어떤 단어들이 각 LLM "시대"에 함께 자주 나타나는지에 대한 분류이다. 엄격한 구분은 아니지만, "초기" 대 "후기" LLM 출력이 어떻게 읽히는지 대략적인 감을 줄 것이다.

**2023년~2024년 중반 (GPT-4):** additionally, boasts, bolstered, crucial, delve, emphasizing, enduring, garner, intricate/intricacies, interplay, key, landscape, meticulous/meticulously, pivotal, underscore, tapestry, testament, valuable, vibrant

**2024년 중반~2025년 중반 (GPT-4o):** align with, bolstered, crucial, emphasizing, enhance, enduring, fostering, highlighting, pivotal, showcasing, underscore, vibrant

**2025년 중반 이후 (GPT-5):** emphasizing, enhance, highlighting, showcasing (+ "주목도, 출처 귀속, 미디어 보도에 대한 과도한 강조"와 관련된 단어들)

맥락을 고려해야 한다. 예를 들어, "underscore"의 비유적 사용은 초기 AI 텍스트에서 편재하지만, 이 단어는 문자 그대로의 밑줄 표시나 부수 음악을 지칭할 수도 있다.

#### 예시

> Somali cuisine is an intricate and diverse fusion of a multitude of culinary influences, drawing from the rich tapestry of Arab, Indian, and Italian flavours. This culinary tapestry is a direct result of Somalia's longstanding heritage of vibrant trade and bustling commerce. [...]
>
> Additionally, a distinctive feature of Somali culinary tradition is the incorporation of camel meat and milk. They are considered a delicacy and serve as cherished and fundamental elements in the rich tapestry of Somali cuisine. [...]
>
> An enduring testament to the influence of Italian colonial rule in Somalia is the widespread adoption of pasta and lasagne in the local culinary landscape, espicially in the south, showcasing how these dishes have integrated into the traditional diet alongside rice. [...]
>
> Additionally, Somali merchants played a pivotal role in the global coffee trade, being one of the first to export coffee beans.
>
> --- Somali people 문서의 해당 편집에서 발췌

> The inscriptions also offer valuable insights into the construction of the mosque. They record the names of the key craftsmen involved, including Mason Ahmad b. Muhammad, known as Haddad (the smith or iron-worker), and Hjajji Muhammad, the tile-cutter from Tabriz. These names highlight the collaborative nature of mosque construction and emphasize the contributions of skilled artisans. [...] For example, the repeated invocation of the names of Muhammad and the Twelve Imams in Kufic script highlights the Shi'ite character of the mosque and links its construction to the broader context of the Ilkhanid state's official adoption of Shi'ism under Oljeitu. [...] This inscription, commissioned during the reign of the Aq Qoyunlu ruler Uzun Hasan, also underscores the enduring practice of pious patronage for mosque upkeep and renovation.
>
> --- Jameh Mosque of Ashtarjan 문서의 해당 편집에서 발췌. 해당 텍스트는 사용자 하위 페이지의 해당 편집에서 붙여넣기된 것임

### 기본 계사(copula, 'is'/'are' 등의 연결 동사) 구문 회피

**주의할 단어:** serves as/stands as/marks/represents [a], boasts/features/offers [a]

LLM이 생성한 텍스트는 *serves as a*나 *mark the* 같은 구문을 계사(copula)인 *is*나 *are*를 사용하는 더 단순한 표현 대신 자주 사용한다. 한 연구에서는 2023년 학술 글쓰기에서 *is*와 *are*의 사용이 10% 이상 감소했으며, 그 이전에는 빈도에 큰 변화가 없었음을 기록했다.[13] 마찬가지로, LLM은 *has*를 사용하는 보다 중립적인 표현 대신 *features*, *offers* 등을 사용하는 문구를 선호한다. 때로는 이러한 구문이 더 복잡해지기도 한다. 예를 들어, *was a candidate*(후보였다) 대신 *ventured into politics as a candidate*(후보로서 정계에 뛰어들었다)와 같은 식이다.

이는 AI 교정 편집에서 특히 두드러지며, 이런 방식으로 텍스트를 "개선"하는 경우가 많다. 위의 연구에서는 GPT-3.5에 10,000개의 초록에 대해 "다음 문장을 수정하시오"라는 프롬프트를 주었을 때, 수정된 버전에서 *is*와 *are*가 덜 등장했음을 입증하기도 했다.[13]

참고: 이 징후는 "[문서 주제]는 ~이다..."와 같은 형식의 위키백과 도입부에는 적용되지 않는다. LLM은 부분적으로 위키백과를 학습 데이터로 사용하기 때문에 도입부를 모방할 수 있는 충분한 예시를 보유하고 있다.

#### 예시

```diff
- Gallery 825 on La Cienega Boulevard, which was purchased in 1958, is LAAA's exhibition arm for contemporary art. There are four individual gallery spaces[...]
+ Gallery 825 on La Cienega Boulevard serves as LAAA's exhibition space for contemporary art. The gallery features four separate spaces[...]
```

> --- Los Angeles Art Association 문서의 해당 편집에서 발췌

```diff
- It is Malaysia's first Malay daily afternoon Tabloid [...] The Harian Metro was established in March 1991 and is the first and oldest Malay-language tabloid [...]
+ It was established in March 1991 as Malaysia's first Malay-language afternoon tabloid [...] Harian Metro holds the distinction of being the first and oldest Malay-language tabloid [...]
```

> --- Harian Metro 문서의 해당 편집에서 발췌

### 부정 대구(Negative parallelisms)

LLM이 주제를 기술할 때, 그 출력은 마치 흔한 오해를 바로잡거나, 독자가 해당 주제에 대해 불완전하거나 잘못된 결론에 도달할 수 있다고 가정하는 것처럼 보일 수 있다. 이런 종류의 대조는 이전에 언급된 하나 이상의 특성과 함께(또는 대신) 주제가 가질 수 있는 다른 특성을 지적함으로써 그런 사고방식에 소급적으로 도전하려는 것처럼 느껴질 수 있다. 이는 인간 작성자들(특히 "흔한 오해" 또는 "미신 타파" 목록형 글에서) 사이에서도 흔하지만, 전형적으로 "AI 징후"로 간주된다.

#### X뿐만 아니라 Y도 (Not just X, but also Y)

LLM은 균형 잡히고 사려 깊게 보이려는 시도로 "Not only ... but ..." 또는 "It is not just ..., it's ..."와 같이 "not", "but", "however"를 포함하는 대구 구문을 흔히 사용한다.[14][1][12]

##### 예시

> Self-Portrait by Yayoi Kusama, executed in 2010 and currently preserved in the famous Uffizi Gallery in Florence, constitutes not only a work of self-representation, but a visual document of her obsessions, visual strategies and psychobiographical narratives.
>
> --- Self-portrait (Yayoi Kusama) 문서의 해당 편집에서 발췌

> It's not just about the beat riding under the vocals; it's part of the aggression and atmosphere.
>
> --- Draft:Critikal! The Rapper 문서의 해당 편집에서 발췌

> I appreciate the feedback so far, but I want to clarify something that's being overlooked. The issue here isn't just sourcing---it's framing. There's a visible, growing movement around Northern English identity, documented across academic literature, social media, and grassroots activism. The fact that it doesn't always use the exact phrase "Northern English nationalism" doesn't mean it doesn't exist. Movements evolve before they're neatly labelled.
>
> TikTok campaigns, dialect revival, and regional symbolism (like St Oswald's stripes) are part of a broader cultural shift. Dismissing these as "not notable" or "original research" while allowing pages on Cornish nationalism, Wessex regionalism, and Yorkshire separatism suggests an inconsistency in how regional identity is treated. That's not just a sourcing issue---it's a systemic bias.
>
> --- Wikipedia:Articles for deletion/Northern English nationalism 문서의 해당 편집에서 발췌. 이 예시에는 em 대시와 둥근 따옴표도 포함되어 있음

다음은 여러 문장에 걸친 부정 대구의 예시이다:

> He hailed from the esteemed Duse family, renowned for their theatrical legacy. Eugenio's life, however, took a path that intertwined both personal ambition and familial complexities.
>
> --- Eugenio Duse 문서의 해당 편집에서 발췌

#### X가 아니라 Y (Not X, but Y)

또 다른 흔한 LLM 패턴은 특정 대상이 첫 번째 특성을 전혀 갖지 않는다고 명시적으로 서술하는 대구이다. 이러한 구문은 "It's not ..., it's ..." 또는 "no ..., no ..., just ..."로 표현되는 경우가 많다.[10]

##### 예시

> The viewer is presented with a self-image that is not grounded in visual mastery, but in what Amelia Jones terms "the performative enactment of subjectivity".
>
> [...]
>
> This dispersal is not dissolution. Rather, it constitutes what Deleuze might describe as "becoming"---an identity in flux, constituted through iterative difference. Through this lens, Kusama's self-portrait is not a mirror but a portal: not a representation of self, but a mechanism for its constant reinvention.
>
> --- Self-portrait (Yayoi Kusama) 문서의 해당 편집에서 발췌

> You say these sources "cover multiple events"? False. They echo the same viral incident and do it through a limited lens. This isn't WP:NBIO --- it's WP:1EVENT in disguise, trying to wear a press badge like armor.
>
> [...]
>
> Now let's talk BLP1E: This person is only in the news because of one isolated controversy. Not a career, not a body of work, not sustained relevance --- just an algorithmic moment. And if we're really upholding Wikipedia's values, we don't preserve pages built on the backs of virality alone, especially when it risks long-term harm to a living subject without lasting notability.
>
> "Might as well get back on topic."
>
> Then let's stay on topic, and the topic is not who feels warm fuzzies from visibility, it's whether this article meets the threshold for inclusion. It doesn't.
>
> And finally --- if you don't want "a wall of text," maybe don't build a wall of shallow logic and expect people not to knock it down. This ain't bludgeoning --- it's surgical teardown of a weak argument hiding behind fake neutrality.
>
> --- Wikipedia:Articles for deletion/Lilly Contino 문서의 해당 편집에서 발췌

### 셋의 규칙 (Rule of three)

LLM은 '셋의 규칙(rule of three)'을 과도하게 사용한다. 이는 "형용사, 형용사, 형용사"에서 "짧은 구, 짧은 구, 그리고 짧은 구"에 이르기까지 다양한 형태를 취할 수 있다.[1][10] LLM은 피상적인 분석을 더 포괄적으로 보이게 하기 위해 이 구조를 자주 사용한다.

#### 예시

> The Amaze Conference brings together global SEO professionals, marketing experts, and growth hackers to discuss the latest trends in digital marketing. The event features keynote sessions, panel discussions, and networking opportunities.
>
> --- Draft:Amaze Conference에서 발췌

### 우아한 변주 (Elegant variation)

*AI에 국한되지 않는 이 주제에 대한 문체 에세이는 Wikipedia:The problem with elegant variation을 참조.*

생성형 AI에는 같은 단어를 너무 자주 재사용하지 않도록 하는 반복 패널티(repetition-penalty) 코드가 있다.[4] 예를 들어, 출력이 주인공의 이름을 먼저 제시한 후, 다시 언급할 때 계속해서 다른 동의어나 관련 용어(예: protagonist, key player, eponymous character)를 반복적으로 사용할 수 있다. 일부 영어 교사들은 학생들에게 우아한 변주(elegant variation)를 사용하거나 단어의 과도한 반복을 피하도록 기대할 수 있지만, 저널리즘에서는 이러한 사용이 지양될 수 있다. The Guardian의 편집자들은 당근에 관한 기사 초안을 조롱하며 이런 우아한 변주를 "POV" 또는 "popular orange vegetables(인기 있는 주황색 채소)"라고 부른 바 있다.[15]

참고: 사용자가 여러 번의 개별 편집에서 AI 생성 콘텐츠를 여러 개 추가하는 경우, 각 텍스트가 독립적으로 생성되었을 수 있으므로 이 징후가 적용되지 않을 수 있다.

#### 예시

다음 예시에서 오른쪽 열의 강조된 단어들은 AI 재작성에 의해 도입된 우아한 변주를 보여준다. 원문(왼쪽)은 직접적이고 구체적인 언어를 사용하는 반면, AI 버전(오른쪽)은 동의어와 우회적 표현으로 대체한다:

> Original: "Vierny, after a visit in Moscow in the early 1970's, committed to supporting artists resisting the constraints of socialist realism and discovered Yankilevskly, among others such as Ilya Kabakov and Erik Bulatov."
>
> AI rewrite: "In the challenging climate of **Soviet artistic constraints**, Yankilevsky, alongside other **non-conformist artists**, faced obstacles in expressing **their creativity** freely. Dina Vierny, recognizing the immense talent and the struggle these artists endured, [...] **artistic aspirations**. [...]
>
> In this new chapter of his life, Yankilevsky found himsel[f among] minded artists who, despite diverse styles, shared a commo[n struggle against the] confines of state-imposed artistic norms, particularly social[ist realism]. The move to Paris facilitated an environment where Yan[kilevsky could freely explore] and exhibit his **distinctive artistic vision** without the cons[traints of the Soviet] regime. Dina Vierny's **unwavering support and commitment** [to these] artists played a **crucial role** in **fostering** a space where [they could thrive,] **contributing to the rich tapestry of artistic expression** in th[e emigre community of] Paris. Vierny's commitment culminated in the ground[breaking exhibition "L'] Avant-Garde - Moscow 1973" at her Saint-Germain-des[-Pres gallery, presenting a] diverse yet united front of **non-conformist artists** challeng[ing the norms of their] time."
>
> --- Vladimir Yankilevsky 문서의 해당 편집에서 발췌

## 스타일

### 제목 대문자 표기 (Title case)

*이 주제에 대한 AI와 무관한 일반 지침은 [Wikipedia:Manual of Style/Capital letters -- Headings, headers, and captions](https://en.wikipedia.org/wiki/Wikipedia:Manual_of_Style/Capital_letters#Headings,_headers,_and_captions)를 참고하라.*

AI 챗봇은 문단 제목에서 주요 단어를 모두 대문자로 표기하는 강한 경향이 있다.[1]

**예시:**

> Global Context: Critical Mineral Demand
>
> According to a 2023 report by Goldman Sachs, the global market for critical minerals [...]
>
> Strategic Negotiations and Global Partnerships
>
> In 2014, Katalayi was appointed senior executive adviser to the chairman of the board of Gecamines [...]
>
> High-Stakes Deals: Glencore, China, and Russia
>
> There was also interest from Moscow for strategic Congolese assets. [...]
>
> --- Arthur Katalayi 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Arthur_Katalayi&oldid=)에서 발췌

### 굵은 글씨의 남용

*이 주제에 대한 AI와 무관한 일반 지침은 [Wikipedia:Manual of Style/Text formatting -- Boldface](https://en.wikipedia.org/wiki/Wikipedia:Manual_of_Style/Text_formatting#Boldface)를 참고하라.*

AI 챗봇은 다양한 구문을 과도하고 기계적인 방식으로 굵은 글씨로 강조할 수 있다. README 파일, 팬 위키, 사용 설명서, 판매 홍보 자료, 프레젠테이션 슬라이드, 리스티클(listicle) 등 굵은 글씨를 많이 사용하는 자료에서 물려받은 습관 중 하나는, 선택한 단어나 구문이 나올 때마다 굵게 강조하는 것이며, 흔히 "핵심 요약(key takeaways)" 방식을 따른다. 일부 최신 대규모 언어 모델이나 앱에는 굵은 글씨 남용을 피하라는 지시가 포함되어 있다.

**예시:**

> A **leveraged buyout** (**LBO**) is characterized by the extensive use of **debt financing** to acquire a company. This financing structure enables **private equity firms** and **financial sponsors** to control businesses while investing a relatively small portion of their own **equity**. The acquired company's **assets** and future **cash flows** serve as **collateral** for the debt, making lenders more willing to provide financing.
>
> --- Leveraged buyout 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Leveraged_buyout&oldid=)에서 발췌

> **50 Scientists and Thinkers in AI Safety** with significant influence on the field of **alignment**, **containment**, and **risk mitigation**. The list includes their **Productive Years**, their estimated **P(doom)** (probability of existential catastrophe), a one-sentence summary of their **contribution to AI Safety**, and their **Wikipedia link**.
>
> --- P(doom) 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=P(doom)&oldid=)에서 발췌

### 인라인 헤더 세로 목록

*이 주제에 대한 AI와 무관한 일반 지침은 [Wikipedia:Manual of Style/Lists -- Use prose where understood easily](https://en.wikipedia.org/wiki/Wikipedia:Manual_of_Style/Lists#Use_prose_where_understood_easily)를 참고하라.*

AI 챗봇의 출력에는 특정 방식으로 서식이 지정된 세로 목록이 자주 포함된다. 순서가 있는 목록이든 없는 목록이든, 목록 표시자(번호, 글머리 기호, 대시 등) 뒤에 인라인 굵은 글씨 헤더가 오고, 콜론으로 나머지 설명 텍스트와 구분되는 형태이다.

올바른 wikitext 대신, 비순서 목록의 글머리 기호가 글머리 기호 문자, 하이픈(-), 엔 대시(en dash), 해시(#), 이모지 또는 유사한 문자로 나타날 수 있다. 순서 목록(즉, 번호 목록)은 표준 wikitext 대신 명시적 번호(예: 1.)를 사용할 수 있다. 화면에 표시되는 텍스트를 그대로 복사하면 일부 서식 정보가 손실되며, 줄바꿈도 사라질 수 있다.

**예시:**

> 1\. Historical Context Post-WWII Era: The world was rapidly changing after WWII, [...] 2. Nuclear Arms Race: Following the U.S. atomic bombings, the Soviet Union detonated its first bomb in 1949, [...] 3. Key Figures Edward Teller: A Hungarian physicist who advocated for the development of more powerful nuclear weapons, [...] 4. Technical Details of Sundial Hydrogen Bomb: The design of Sundial involved a hydrogen bomb [...] 5. Destructive Potential: If detonated, Sundial would create a fireball up to 50 kilometers in diameter, [...] 6. Consequences and Reactions Global Impact: The explosion would lead to an apocalyptic nuclear winter, [...] 7. Political Reactions: The U.S. military and scientists expressed horror at the implications of such a weapon, [...] 8. Modern Implications Current Nuclear Arsenal: Today, there are approximately 12,000 nuclear weapons worldwide, [...] 9. Key Takeaways Understanding the Madness: The concept of Project Sundial highlights the extremes of human ingenuity [...] 10. Questions to Consider What were the motivations behind the development of Project Sundial? [...]
>
> --- Sundial (weapon) 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Sundial_(weapon)&oldid=)에서 발췌

> **Conflict of Interest (COI)/Autobiography:** While I understand the concern regarding my username [...]
>
> **Notability (GNG and NPOLITICIAN):** I have revised the article to focus on factual details [...]
>
> **Original Research (WP) and Promotional Tone:** I have worked on removing original research [...]
>
> **Article Move to Main Namespace:** Moving the draft to the main namespace after the AFC review [...]
>
> --- Wikipedia:Articles for deletion/Sarwan Kumar Bheel 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Wikipedia:Articles_for_deletion/Sarwan_Kumar_Bheel&oldid=)에서 발췌

> AVO consists of three key layers:
>
> **SEO (Search Engine Optimization):** Traditional methods for improving visibility in search engine results through content, technical, and on-page optimization.
>
> **AEO (Answer Engine Optimization):** Techniques focused on optimizing content for voice assistants and answer boxes, such as featured snippets and structured data.
>
> **GEO (Generative Engine Optimization):** Strategies for ensuring businesses are cited as credible sources in responses generated by large language models (LLMs).
>
> --- Draft:AI Visibility Optimization (AVO) 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Draft:AI_Visibility_Optimization_(AVO)&oldid=)에서 발췌. 셋의 법칙(rule of three)도 주목하라.

> **Mass Content Removal:** The user removed over 20,000 characters of reliably sourced content in a single edit, reducing the number of citations from 34 to 8, without any prior engagement on the Talk page. **Disruptive Tagging:** Despite the article being supported by 34 high-quality international secondary sources (Wall Street Journal, Bloomberg, Financial Times, etc.), the user implemented excessive "citation needed" tags as a form of visual vandalism to discredit the content. **Refusal to engage (WP:BRD):** The user was notified of WP:V and WP:DE policies on their talk page but has failed to justify these massive deletions, suggesting a coordinated attempt at de-legitimizing the subject. **Context:** Given the high-profile nature of the subject in global finance and mining (notably the AstraZeneca/EsoBiotec $1B M&A), the page is currently vulnerable to reputation-based sabotage.
>
> --- Wikipedia:Requests for page protection/Increase 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Wikipedia:Requests_for_page_protection/Increase&oldid=)에서 발췌

### 이모지

AI 챗봇은 이모지를 자주 사용한다.[12] 특히 문단 제목이나 글머리 기호 앞에 이모지를 배치하여 장식하는 경우가 있다. 이 현상은 토론 페이지 댓글에서 가장 눈에 띈다.

**예시:**

> Let's decode exactly what's happening here:
>
> Cognitive Dissonance Pattern: You've proven authorship, demonstrated originality, and introduced new frameworks, yet they're defending a system that explicitly disallows recognition of originators unless a third party writes about them first. [...]
>
> Structural Gatekeeping: Wikipedia policy favors: [...]
>
> Underlying Motivation: Why would a human fight you on this? [...]
>
> What You're Actually Dealing With: This is not a debate about rules. [...]
>
> --- Wikipedia:Village pump (policy) 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Wikipedia:Village_pump_(policy)&oldid=)에서 발췌

> Traditional Sanskrit Name: Trikonamiti [...]
>
> 1\. Vedic Era (c. 1200 BCE -- 500 BCE) [...]
>
> 2\. Sine of the Bow: Sanskrit Terminology [...]
>
> 3\. Aryabhata (476 CE) [...]
>
> 4\. Varahamihira (6th Century CE) [...]
>
> 5\. Bhaskaracarya II (12th Century CE) [...]
>
> Indian Legacy Spreads
>
> --- History of trigonometry 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=History_of_trigonometry&oldid=)에서 발췌

### em dash(엠 대시)의 남용

*대시 사용에 대한 AI와 무관한 일반 지침은 [Wikipedia:Manual of Style -- Dashes](https://en.wikipedia.org/wiki/Wikipedia:Manual_of_Style#Dashes)를 참고하라.*

인간 편집자와 작가들도 em dash(엠 대시, --)를 자주 사용하지만, LLM의 출력은 같은 장르의 비전문적 인간 작성 텍스트보다 더 자주 사용하며, 인간이 쉼표, 괄호, 콜론, 또는 (오용된) 하이픈(-) 및 en dash(엔 대시)를 사용할 위치에 em dash를 사용한다. LLM은 특히 판매 문구처럼 "강조된" 글쓰기를 모방하여 절이나 병렬 구조를 과도하게 강조하는 상투적이고 공식적인 방식으로 em dash를 사용하는 경향이 있다.[12][10]

이 징후는 단독으로 사용하기보다 다른 지표와 함께 고려할 때 가장 유용하다. 문서 본문보다 토론 페이지에서 훨씬 더 흔하게 나타난다. 또한, LLM의 em dash 사용이 다소 악명 높아짐에 따라, 일부 AI 기업은 최신 챗봇에서 em dash 사용을 억제하려고 시도했으며, 특히 OpenAI의 GPT-5.1이 대표적이다.[16]

**예시:**

> The term "Dutch Caribbean" is not used in the statute and is primarily promoted by Dutch institutions, not by the people of the autonomous countries themselves. In practice, many Dutch organizations and businesses use it for their own convenience, even placing it in addresses -- e.g., "Curacao, Dutch Caribbean" -- but this only adds confusion internationally and erases national identity. You don't say "Netherlands, Europe" as an address -- yet this kind of mislabeling continues.
>
> --- Talk:Dutch Caribbean 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=&diff=1286082047&oldid=)에서 발췌. 이 메시지는 굵은 글씨도 남용하고 있다.

> you're right about one thing -- we do seem to have different interpretations of what policy-based discussion entails. [...]
>
> When WP:BLP1E says "one event," it's shorthand -- and the supporting essays, past AfD precedents, and practical enforcement show that "two incidents of fleeting attention" still often fall under the protective scope of BLP1E. This isn't "imagining" what policy should be -- it's recognizing how community consensus has shaped its application.
>
> Yes, WP:GNG, WP:NOTNEWS, WP:NOTGOSSIP, and the rest of WP:BLP all matter -- and I've cited or echoed each of them throughout. [...] If a subject lacks enduring, in-depth, independent coverage -- and instead rides waves of sensational, short-lived attention -- then we're not talking about encyclopedic significance. [...]
>
> [...] And consensus doesn't grow from silence -- it grows from critique, correction, and clarity.
>
> If we disagree on that, then yes -- we're speaking different languages.
>
> --- Wikipedia:Articles for deletion/Lilly Contino 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Wikipedia:Articles_for_deletion/Lilly_Contino&oldid=)에서 발췌

> The current revision of the article fully complies with Wikipedia's core content policies -- including WP:V (Verifiability), WP:RS (Reliable Sources), and WP:BLP (Biographies of Living Persons) -- with all significant claims supported by multiple independent and reputable international sources.
>
> [...] However, to date, no editor -- including yourself -- has identified any specific passages in the current version that were generated by AI or that fail to meet Wikipedia's content standards. [...]
>
> Given the article's current state -- well-sourced, policy-compliant, and collaboratively improved -- the continued presence of the "LLM advisory" banner is unwarranted.
>
> --- Talk:Arthur Katalayi 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Talk:Arthur_Katalayi&oldid=)에서 발췌

### 표의 부적절한 사용

AI는 산문으로 더 잘 표현할 수 있는 내용을 불필요한 작은 표로 만드는 경향이 있다.

**예시:**

> Market and Statistics
>
> The Indian biobanking market was valued at approximately USD 2,101 million in 2024. The sector is expanding to support the "Atmanirbhar Bharat" (Self-reliant India) initiative in healthcare research.
>
> Key Statistics of Indian Biobanking (2024-2025)
>
> | Metric | Figure |
> |---|---|
> | Market Valuation (2024) | ~USD 2.1 billion |
> | Major Accredited Facilities | NLDB, CBR Biobank, THSTI, Karkinos |
> | GenomeIndia Diversity | 99 ethnic groups (32 tribal, 53 non-tribal) |
>
> --- Draft:Biobanks in India 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Draft:Biobanks_in_India&oldid=)에서 발췌

### 둥근 따옴표와 어포스트로피 (Curly quotation marks and apostrophes)

*이 주제에 대한 AI와 무관한 일반 지침은 [Wikipedia:Manual of Style -- Quotation characters](https://en.wikipedia.org/wiki/Wikipedia:Manual_of_Style#Quotation_characters) 및 [Wikipedia:Manual of Style -- Apostrophes](https://en.wikipedia.org/wiki/Wikipedia:Manual_of_Style#Apostrophes)를 참고하라.*

ChatGPT와 DeepSeek는 일반적으로 직선 따옴표(straight quotation marks) 대신 둥근 따옴표(curly quotation marks)를 사용한다. 일부 경우 AI 챗봇은 같은 응답 내에서 둥근 따옴표와 직선 따옴표를 일관성 없이 혼용한다. 또한 축약형이나 소유격에서 직선 어포스트로피 대신 둥근 어포스트로피(둥근 오른쪽 작은 따옴표와 동일한 문자)를 사용하는 경향이 있으며, 이것 역시 일관성 없이 사용될 수 있다.

둥근 따옴표만으로는 LLM 사용을 증명할 수 없다. Microsoft Word에는 직선 따옴표를 둥근 따옴표로 변환하는 "스마트 따옴표" 기능이 있다. macOS 및 iOS 기기의 기본 시스템 전체 설정에도 동일한 기능이 있으나, 일부 애플리케이션에서는 예외이다(또는 프로그래밍에 필요한 경우 끌 수 있다). LanguageTool과 같은 문법 교정 도구에도 이러한 기능이 있을 수 있다. 둥근 따옴표와 어포스트로피는 주요 신문과 같은 전문적으로 조판된 출판물에서 흔히 볼 수 있다. [Citer](https://citer.toolforge.org/)와 같은 인용 도구는 웹 페이지 제목에 나타나는 둥근 따옴표를 그대로 반복할 수 있다.

위키백과에서는 사용자가 텍스트 표시에 사용되는 글꼴을 사용자 정의할 수 있다는 점에 유의하라. 일부 글꼴은 둥근 어포스트로피를 직선으로 표시하므로, 이 경우 사용자에게는 그 차이가 보이지 않는다. 또한, Gemini과 Claude 모델은 일반적으로 둥근 따옴표를 사용하지 않는다.

### 제목줄 (Subject lines)

AI 챗봇이 생성한 사용자 메시지 및 차단 해제 요청은 때때로 이메일 양식의 제목(Subject) 필드에 붙여넣기 위한 텍스트로 시작된다.

**예시:**

> Subject: Request for Permission to Edit Wikipedia Article - "Dog"
>
> --- Talk:Dog 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Talk:Dog&oldid=)에서 발췌

> Subject: Request for Review and Clarification Regarding Draft Article
>
> --- Wikipedia:WikiProject Articles for creation/Help desk 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Wikipedia:WikiProject_Articles_for_creation/Help_desk&oldid=)에서 발췌

### 제목 수준 건너뛰기 (Skipping heading levels)

AI 챗봇은 2단계 제목(==)을 건너뛰고 3단계(===)부터 문단을 시작하는 경향이 있다. 이는 위키백과의 접근성 및 스타일 관례에 어긋나므로, 수동으로 서식을 지정한 페이지에서 이런 특이점이 나타나는 경우는 매우 드물다.

### 제목 앞의 구분선 (Thematic breaks before headings)

AI 챗봇은 텍스트에서 각 제목 앞에 구분선(----)을 포함하는 경우가 있다(이는 Markdown 출력에서 흔히 볼 수 있다).

**예시:**

> ```
> === Distinction from French "''[[List of English words of French origin|chiffon]]''" ===
> Some claims have suggested that ''Ichafu'' derives from the French word chiffon [...]
> [...]
> ----
> == History ==
> Headwrapping practices among Igbo women are documented in historical and ethnographic sources [...]
> [...]
> ----
> == Form and construction ==
> ```
>
> --- Draft:Ichafu 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Draft:Ichafu&oldid=) 및 Ichafu (headdress) 문서의 [해당 아카이브 편집](https://web.archive.org/web/20260323205345/https://en.wikipedia.org/wiki/Ichafu_(headdress))에서 발췌

---

## 사용자에게 보내는 의사소통

### 협력적 대화 표현

**주의할 단어:** *I hope this helps, Of course!, Certainly!, You're absolutely right!, Would you like..., is there anything else, let me know, more detailed breakdown, here is a ...*

편집자들은 때때로 AI 챗봇에서 받은 텍스트를 문서 내용이 아닌 서신, 초안 작성 또는 조언의 형태로 붙여넣는 경우가 있다. 이는 문서 본문이나 주석(<!-- -->) 안에 나타날 수 있다. 위키백과 문서나 댓글을 작성하도록 프롬프트를 받은 챗봇은 해당 텍스트가 위키백과용임을 명시적으로 언급하기도 하며, 출력 내에서 다양한 정책과 지침을 언급할 수 있다. 이때 흔히 해당 관례가 위키백과의 것임을 명시적으로 밝힌다.

**예시:**

> In this section, we will discuss the background information related to the topic of the report. This will include a discussion of relevant literature, previous research, and any theoretical frameworks or concepts that underpin the study. The purpose is to provide a comprehensive understanding of the subject matter and to inform the reader about the existing knowledge and gaps in the field.
>
> --- Metaphysics 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=&diff=1172646802&oldid=)에서 발췌

> Including photos of the forge (as above) and its tools would enrich the article's section on culture or economy, [...] Visual resources can also highlight Ronco Canavese's landscape and landmarks. For instance, a map [...] could be added to orient readers geographically. The village's scenery [...] could be illustrated with an image. Several such photographs are available (e.g., on Wikimedia Commons) that show Ronco's panoramic view, [...] Historical images, if any exist [...] would also add depth to the article. Additionally, the town's notable buildings and sites can be visually presented: [...] Including an image of the Santuario di San Besso [...] could further engage readers. By leveraging these visual aids -- maps, photographs of natural and cultural sites -- the expanded article can provide a richer, more immersive picture of Ronco Canavese.
>
> --- Ronco Canavese 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Ronco_Canavese&oldid=)에서 발췌

> If you plan to add this information to the "Animal Cruelty Controversy" section of Foshan's Wikipedia page, ensure that the content is presented in a neutral tone, supported by reliable sources, and adheres to Wikipedia's guidelines on verifiability and neutrality.
>
> --- Foshan 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Foshan&oldid=)에서 발췌

> Here's a template for your wiki user page. You can copy and paste this onto your user page and customize it further.
>
> --- 한 사용자 페이지의 [해당 편집](https://en.wikipedia.org/w/index.php?title=User:&oldid=)에서 발췌

> Final important tip: The ~~~~ at the very end is Wikipedia markup that automatically
>
> --- Talk:Test automation management tools 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=&diff=1297191187&oldid=)에서 발췌. 이 메시지는 예기치 않게 끝나기도 한다.

### 학습 데이터 기준일(knowledge cutoff) 면책 조항 및 출처 부족에 대한 추측

**주의할 단어:** *as of [date],[c] Up to my last training update, as of my last knowledge update, While specific details are limited/scarce..., not widely available/documented/disclosed, ...in the provided/available sources/search results..., based on available information ...*

학습 데이터 기준일 면책 조항이란 AI 챗봇이 제공하는 정보가 불완전하거나 부정확하거나 오래되었을 수 있음을 나타내기 위해 사용하는 문구이다.

LLM의 학습 데이터 기준일이 고정되어 있는 경우(보통 모델의 마지막 학습 갱신 시점), 그 이후의 사건이나 발전에 대한 정보를 제공할 수 없으며, 사용자에게 이 기준일을 상기시키는 면책 조항을 출력하는 경우가 많다. 이는 일반적으로 제공된 정보가 특정 날짜까지만 정확하다는 문구의 형태를 띤다.

검색 증강 생성(retrieval-augmented generation)을 갖춘 LLM이 주어진 주제에 대한 출처를 찾지 못하거나, 사용자가 제공한 출처에 정보가 포함되어 있지 않은 경우, 그 사실을 알리는 문구를 출력하는 경우가 많으며, 이는 학습 데이터 기준일 면책 조항과 유사하다. 또한 해당 정보가 "아마도" 무엇일지, 왜 중요한지에 대한 텍스트를 함께 제시하기도 한다. 이 정보는 전적으로 추측이며("문서화되지 않았다"는 주장 자체를 포함하여), 느슨하게 관련된 주제에 기반하거나 완전히 날조된 것일 수 있다. 해당 미지의 정보가 개인의 사생활에 관한 것일 때, 이 면책 조항은 종종 해당 인물이 "낮은 자세를 유지한다", "개인적인 세부 사항을 비공개로 한다" 등으로 주장한다. 이 역시 추측에 불과하다.

**예시:**

> While specific details about Kumarapediya's history or economy are not extensively documented in readily available sources, ...
>
> --- Kumarapediya 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Kumarapediya&oldid=)에서 발췌

> While specific information about the fauna of Studnicni hora is limited in the provided search results, the mountain likely supports...
>
> --- Studnicni hora 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Studni%C4%8Dn%C3%AD_hora&oldid=)에서 발췌

> Though the details of these resistance efforts aren't widely documented, they highlight her bravery...
>
> --- Throwing Curves: Eva Zeisel 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Throwing_Curves:_Eva_Zeisel&oldid=)에서 발췌

> As of my last knowledge update in January 2022, I don't have specific information about the current status or developments related to the "Chester Mental Health Center" in today's era.
>
> --- Chester Mental Health Center 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=&diff=1186779926&oldid=)에서 발췌

> Below is a detailed overview based on available information:
>
> --- Draft:The Good, The Bad, The Dollar Menu 2에서 발췌

> Matthews Manamela keeps much of his personal life private, choosing instead to focus public attention on his professional work and performances.
>
> --- Draft:Matthews Manamela에서 발췌

> As an underground release, detailed lyrics are not widely transcribed on major sites like Genius or AZLyrics, likely due to the artist's limited mainstream exposure. My analysis is based on available track titles, featured artists, public song snippets from streaming platforms (e.g., Spotify, Apple Music, Deezer), and Honcho's overall discography themes. Where lyrics aren't fully accessible, I've inferred common motifs from similar trap tracks and Honcho's style. ...For deeper insights, listening to tracks on platforms like Spotify or Deezer is recommended, as lyrics and production details aren't fully documented in public sources.
>
> --- Draft:Haiti Honcho에서 발췌

### 문구 템플릿 및 자리표시자 텍스트

AI 챗봇은 LLM 사용자가 자신의 용도에 맞는 단어나 구문으로 대체할 수 있도록 빈칸 채우기 형식의 문구 템플릿(Mad Libs 게임에서 볼 수 있는 형태)이 포함된 응답을 생성할 수 있다. 그러나 일부 LLM 사용자는 해당 빈칸을 채우는 것을 잊는다. LLM이 생성하지 않은 템플릿도 초안 및 새 문서용으로 존재한다는 점에 유의하라(예: Wikipedia:Artist biography article template/Preload 및 Category:Article creation templates의 페이지들).

**예시:**

> Subject: Concerns about Inaccurate Information
>
> Dear Wikipedia
>
> I am writing to express my deep concern about the spread of misinformation on your platform. Specifically, I am referring to the article about [Entertainer's Name], which I believe contains inaccurate and harmful information.
>
> --- Talk:Kjersti Flaa 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Talk:Kjersti_Flaa&oldid=)에서 발췌

> Subject: Edit Request for Wikipedia Entry
>
> Dear Wikipedia Editors,
>
> I hope this message finds you well. I am writing to request an edit for the Wikipedia entry I have identified an area within the article that requires updating/improvement. [Describe the specific section or content that needs editing and provide clear reasons why the edit is necessary, including reliable sources if applicable].
>
> --- Talk:Spaghetti 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Talk:Spaghetti&oldid=)에서 발췌

대규모 언어 모델은 인용 필드, 특히 access-date 매개변수(드물게 date 매개변수도)에 "2025-xx-xx"와 같은 자리표시자 날짜를 삽입하여 오류를 발생시킬 수 있다.

**예시:**

> ```
> <ref>{{cite web
> |title=Canadian Screen Music Awards 2025 Winners and Nominees
> |url=URL
> |website=Canadian Screen Music Awards
> |date=2025
> |access-date=2025-XX-XX
> }}</ref>
> ```
>
> --- Michelle Osis 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Michelle_Osis&oldid=)에서 발췌

**검색 링크:**
- [insource:/20[0-9][0-9]-(XX|xx)-(XX|xx)/](https://en.wikipedia.org/w/index.php?search=insource%3A%2F20%5B0-9%5D%5B0-9%5D-%28XX%7Cxx%29-%28XX%7Cxx%29%2F&title=Special%3ASearch&profile=advanced&fulltext=1&ns0=1)

일부 경우 LLM이 생성한 인용에는 다른 필드에도 자리표시자가 포함될 수 있다.

**예시:**

> ```
> {{cite web
> |url=INSERT_SOURCE_URL_30
> |title=Deputy Monitoring of Regional Assistance to Mobilized Soldiers
> |date=2022-11-XX
> |publisher=SOURCE_PUBLISHER
> |accessdate=2024-07-21
> }}
> ```
>
> --- Dmitry Kuznetsov (politician) 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Dmitry_Kuznetsov_(politician)&oldid=)에서 발췌

> ```
> <ref>{{cite web
> |title=Ecos de Amor - Spotify
> |url=PASTE_SPOTIFY_TRACK_URL_HERE
> |website=Spotify
> |access-date=2026-02-09
> }}</ref>
> <ref>{{cite web
> |title=Jesse & Joy - Ecos de Amor (Official Music Video)
> |url=PASTE_YOUTUBE_VIDEO_URL_HERE
> |website=YouTube
> |access-date=2026-02-09
> }}</ref>
> ```
>
> --- Nelly Joy 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Nelly_Joy&oldid=)에서 발췌

LLM이 생성한 정보상자(infobox) 편집에는 출처가 발견되면 텍스트나 이미지를 추가하라는 주석이 포함될 수 있다. 참고: 정보상자 내 주석, 특히 오래된 정보상자의 주석은 흔하며(일부 템플릿은 자동으로 주석을 포함한다) AI 사용의 지표가 아니다. "Add ____" 또는 그 구체적인 표현의 변형이 아닌 다른 것은 오히려 인간이 작성한 텍스트일 가능성이 더 높다.

**예시:**

> ```
> | leader_name = <!-- Add if available with citation -->
> ```
>
> --- Pindi Saidpur 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Pindi_Saidpur&oldid=)에서 발췌

---

## 마크업

### Markdown의 사용

많은 AI 챗봇은 위키백과의 MediaWiki 소프트웨어가 문서 서식을 지정하는 데 사용하는 마크업 언어인 wikitext에 능숙하지 않다. wikitext는 주로 MediaWiki 및 Miraheze와 같은 MediaWiki 기반 플랫폼에서 운영되는 위키에서 발견되는 틈새 마크업 언어이므로, LLM의 학습 데이터에서 wikitext로 서식이 지정된 콘텐츠의 비중은 크지 않다. 챗봇의 말뭉치(corpus)가 수백만 개의 위키백과 문서를 수집하긴 했지만, 이러한 문서는 wikitext 구문을 포함하는 텍스트 파일로 처리되지 않았을 것이다.

챗봇 앱에서 출력 표시는 wikitext와 개념적으로 유사하지만 훨씬 더 널리 사용되는 마크업 언어인 Markdown으로 서식이 지정된다. 한편, 챗봇의 사전 프롬프트(preprompt)는 일반적으로 목록 제공이나 제목 작성 시 Markdown을 사용하도록 지시한다. 즉, 시스템 수준의 지시는 Markdown을 사용하여 출력 서식을 지정하도록 안내하고, 챗봇 앱은 해당 구문을 사용자 화면에서 서식이 지정된 텍스트로 렌더링한다. 예를 들어, Claude Sonnet 3.5(2024년 11월)의 시스템 프롬프트에는 다음이 포함된다:[17]

> Claude uses Markdown formatting. When using Markdown, Claude always follows best practices for clarity and consistency. It always uses a single space after hash symbols for headers (e.g., "# Header 1") and leaves a blank line before and after headers, lists, and code blocks. For emphasis, Claude uses asterisks or underscores consistently (e.g., italic or bold). When creating lists, it aligns items properly and uses a single space after the list marker. For nested bullets in bullet point lists, Claude uses two spaces before the asterisk (*) or hyphen (-) for each level of nesting. For nested bullets in numbered lists, Claude uses three spaces before the number and period (e.g., "1.") for each level of nesting.

위에서 알 수 있듯이, Markdown 구문은 wikitext와 완전히 다르다. Markdown은 굵은 글씨와 기울임 서식에 작은따옴표(') 대신 별표(*) 또는 밑줄(_)을, 문단 제목에 등호(=) 대신 해시 기호(#)를, URL 주위에 대괄호([]) 대신 괄호(())를, 구분선에 하이픈 4개(----) 대신 3개의 기호(---, ***, 또는 ___)를 사용한다.

"문서를 생성하라"는 지시를 받으면, 챗봇은 생성된 출력에 기본적으로 Markdown을 사용하는 경우가 많다. 이 서식은 일부 챗봇 플랫폼의 복사 기능을 통해 클립보드 텍스트에 보존된다. 위키백과용 콘텐츠를 생성하라는 지시를 받으면, 챗봇은 위키백과 호환 코드를 생성해야 한다는 것을 "인식"하고, 출력에 *Would you like me to ... turn this into actual Wikipedia markup format (`wikitext`)?*[d]와 같은 메시지를 포함할 수 있다. 챗봇에게 진행하라고 하면, 결과 구문은 종종 기초적이거나 구문적으로 잘못되었거나 둘 다이다. 챗봇은 시도한 wikitext 콘텐츠를 Markdown 스타일의 펜스드 코드 블록(WP:PRE에 해당하는 구문) 안에 넣을 수 있으며, Markdown 기반 구문과 콘텐츠로 둘러싸게 된다. 이는 플랫폼별 클립보드 복사 기능에 의해서도 보존될 수 있어, 두 마크업 언어의 구문이 모두 나타나는 특징적인 흔적을 남긴다. 여기에는 텍스트에 백틱 3개가 나타나는 것이 포함될 수 있다. 예: ` ```wikitext `.[e]

결함이 있는 wikitext 구문이 Markdown 구문과 혼합되어 있는 것은 콘텐츠가 LLM에 의해 생성되었다는 강력한 지표이며, 특히 Markdown 펜스드 코드 블록 형태인 경우 더욱 그렇다. 그러나 Markdown 단독으로는 그렇게 강력한 지표가 아니다. 소프트웨어 개발자, 연구자, 기술 문서 작성자, 경험 많은 인터넷 사용자는 Obsidian이나 GitHub 같은 도구, 그리고 [Reddit](https://support.reddithelp.com/hc/en-us/articles/360043033952-Formatting-Guide), [Discord](https://support.discord.com/hc/en-us/articles/210298617-Markdown-Text-101-Chat-Formatting-Bold-Italic-Underline), [Slack](https://slack.com/help/articles/202288908-Format-your-messages) 같은 플랫폼에서 Markdown을 자주 사용한다. iOS 메모, Google Docs, Windows 메모장 등 일부 작성 도구와 앱은 Markdown 편집이나 내보내기를 지원한다. Markdown의 보편화로 인해 새 편집자들이 위키백과가 기본적으로 Markdown을 지원할 것으로 기대하거나 추정할 수도 있다.

**예시:**

*참고: [Markdown -- Examples](https://en.wikipedia.org/wiki/Markdown#Examples)*

> I believe this block has become procedurally and substantively unsound. Despite repeatedly raising clear, policy-based concerns, every unblock request has been met with \*\*summary rejection\*\* -- not based on specific diffs or policy violations, but instead on \*\*speculation about motive\*\*, assertions of being "unhelpful", and a general impression that I am "not here to build an encyclopedia". No one has meaningfully addressed the fact that I have \*\*not made disruptive edits\*\*, \*\*not engaged in edit warring\*\*, and have consistently tried to \*\*collaborate through talk page discussion\*\*, citing policy and inviting clarification. Instead, I have encountered a pattern of dismissiveness from several administrators, where reasoned concerns about \*\*in-text attribution of partisan or interpretive claims\*\* have been brushed aside. Rather than engaging with my concerns, some editors have chosen to mock, speculate about my motives, or label my arguments "AI-generated" -- without explaining how they are substantively flawed.
>
> --- 한 사용자 토론 페이지의 [해당 편집](https://en.wikipedia.org/w/index.php?title=&diff=1284964006&oldid=)에서 발췌

> \- The Wikipedia entry does not explicitly mention the "Cyberhero League" being recognized as a winner of the World Future Society's BetaLaunch Technology competition, as detailed in the interview with THE FUTURIST (\[https://consciouscreativity.com/the-futurist-interview-with-dana-klisanin-creator-of-the-cyberhero-league/\](https://consciouscreativity.com/the-futurist-interview-with-dana-klisanin-creator-of-the-cyberhero-league/)). This recognition could be explicitly stated in the "Game design and media consulting" section.
>
> --- Talk:Dana Klisanin 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=&diff=1290202502&oldid=)에서 발췌

여기에서 LLM은 문단 제목을 나타내기 위해 ##을 잘못 사용하고 있으며, MediaWiki는 이를 번호 목록으로 해석한다.

> 1. 1. Geography
>
> Villers-Chief is situated in the Jura Mountains, in the eastern part of the Doubs department. [...]
>
> 1. 1. History
>
> Like many communes in the region, Villers-Chief has an agricultural past. [...]
>
> 1. 1. Administration
>
> Villers-Chief is part of the Canton of Valdahon and the Arrondissement of Pontarlier. [...]
>
> 1. 1. Population
>
> The population of Villers-Chief has seen some fluctuations over the decades, [...]
>
> --- Villers-Chief 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Villers-Chief&oldid=)에서 발췌

### 깨진 wikitext

AI 챗봇은 일반적으로 wikitext와 템플릿에 능숙하지 않으므로, 결함이 있는 구문을 자주 생산한다. 주목할 만한 사례로는 Template:AfC submission과 관련된 깨진 코드가 있는데, 새 편집자들이 Articles for Creation 초안을 제출하는 방법을 챗봇에게 물어볼 수 있기 때문이다. AfC 검토자들 사이의 관련 논의를 참고하라.

**예시:**

> ```
> [[Category:AfC submissions by date/<0030Fri, 13 Jun 2025 08:18:00 +0000202568 ...
> June 2025|sandbox]]
> ```
>
> --- User:Dr. Omokhudu Idogho/sandbox 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=User:Dr._Omokhudu_Idogho/sandbox&oldid=)에서 발췌

### turn0search0

ChatGPT는 문장 끝에 `turn0search0`(유니코드 사용자 영역(Private Use Area) 문자로 둘러싸인 형태)을 포함할 수 있으며, "search" 뒤의 숫자는 텍스트가 진행됨에 따라 증가한다. 증가하는 숫자만 PUA 유니코드로 둘러싸인 더 짧은 대안 형태도 존재한다. 이는 챗봇이 외부 사이트에 링크하는 위치인데, 인간이 대화 내용을 위키백과에 붙여넣을 때 해당 링크가 자리표시자 코드로 변환된 것이다. 이 현상은 2025년 2월에 처음 관찰되었다.

응답 내의 이미지 모음은 `turn0image0`, `turn0image1` 등으로 렌더링될 수도 있다. 드물게 `turn0news0`, `turn1file0`, 또는 `generated-reference-identifier` 등 유사한 스타일의 다른 마크업이 나타날 수도 있다.

**예시:**

> The school is also a center for the US College Board examinations, SAT I & SAT II, and has been recognized as an International Fellowship Centre by Cambridge International Examinations. `cite turn0search1` For more information, you can visit their official website: `cite turn0search0`
>
> --- List of English-medium schools in Bangladesh 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=&diff=1274664396&oldid=)에서 발췌

> \*\*Japanese:\*\* Reze is voiced by Reina Ueda, an established voice actress known for roles such as Cha Hae-In in Solo Leveling and Kanao Tsuyuri in Demon Slayer.`2`
>
> \*\*English:\*\* In the English dub of the anime film, Reze is voiced by Alexis Tipton, noted for her work in series such as Kaguya-sama: Love is War.`3`
>
> [...] The film itself holds a high rating on \*\*Rotten Tomatoes\*\* and has been described as a major anime release of 2025, indicating strong overall reception for the Reze Arc storyline and its adaptation.`5`
>
> --- Draft:Reze (Chainsaw Man)에서 발췌

**검색 링크:**
- [turn0search0 OR turn0search1 OR ... OR turn0search7](https://en.wikipedia.org/w/index.php?title=Special:Search&search=turn0search0+OR+turn0search1+OR+turn0search2+OR+turn0search3+OR+turn0search4+OR+turn0search5+OR+turn0search6+OR+turn0search7&ns0=1&fulltext=Search)
- [turn0image0 OR turn0image1 OR ... OR turn0image7](https://en.wikipedia.org/w/index.php?title=Special:Search&search=turn0image0+OR+turn0image1+OR+turn0image2+OR+turn0image3+OR+turn0image4+OR+turn0image5+OR+turn0image6+OR+turn0image7&ns0=1&fulltext=Search)
- [insource:/turn0(search|image|news|file)[0-9]+/](https://en.wikipedia.org/w/index.php?title=Special:Search&search=insource%3A%2Fturn0%28search%7Cimage%7Cnews%7Cfile%29%5B0-9%5D%2B%2F&ns0=1&fulltext=Search)

### 참조 마크업 버그: contentReference, oaicite, oai_citation, +1, attached_file, grok_card

버그로 인해 ChatGPT는 출력 텍스트에서 참조 링크 대신 `:contentReference[oaicite:0]{index=0}`, `Example+1`, 또는 `oai_citation` 형태의 코드를 추가할 수 있다.

**예시:**

> ```
> :contentReference[oaicite:16]{index=16}
> 1. **Ethnicity clarification**
> - :contentReference[oaicite:17]{index=17}
> * :contentReference[oaicite:18]{index=18} :contentReference[oaicite:19]{index=19}.
> * Denzil Ibbetson's *Panjab Castes* classifies Sial as Rajputs
>   :contentReference[oaicite:20]{index=20}.
> * Historian's blog notes: "The Sial are a clan of Parmara Rajputs..."
>   :contentReference[oaicite:21]{index=21}.
> 2. :contentReference[oaicite:22]{index=22}
> - :contentReference[oaicite:23]{index=23}
> > :contentReference[oaicite:24]{index=24} :contentReference[oaicite:25]{index=25}.
> ```
>
> --- Talk:Sial (tribe) 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=&diff=1294765751&oldid=)에서 발췌

> Key facts needing addition or correction:
>
> 1\. **Group launch & meetings** -- *Independent Together* launched a "Zero Rates Increase Roadshow" on 15 June, with events in Karori, Hataitai, Tawa, and Newtown \[oai\_citation:0\](https://wellington.scoop.co.nz/?p=171473&utm_source=chatgpt.com).
>
> 2\. **Zero-rates pledge and platform** -- The group pledges no rates increases for three years, then only match inflation -- responding to Wellington's 16.9% hike for 2024/25 \[oai\_citation:1\](https://en.wikipedia.org/wiki/Independent_Together?utm_source=chatgpt.com).
>
> --- Talk:Independent Together 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=&diff=1296028135&oldid=)에서 발췌

> This was created conjointly by technical committee ISO/IEC JTC 1/SC 27 (Information security, cybersecurity, and protection of privacy) IT Governance+3ISO+3ISO+3. It belongs to the ISO/IEC 27000 family that talks about information security management systems (ISMS) and related practice controls. Wikipedia+1. The standard gives guidance for information security controls for cloud service providers (CSPs) and cloud service customers (CSCs). Specifically adapted to cloud specific environments like responsibility, virtualization, dynamic provisioning, and multi-tenant infrastructure. Ignyte+3Microsoft Learn+3Google Cloud+3.
>
> --- ISO/IEC 27017 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=ISO/IEC_27017&oldid=)에서 발췌

2025년 가을 기준으로, `[attached_file:1]`, `[web:1]` 등의 태그가 문장 끝에 나타나는 것이 관찰되었다. 이는 Perplexity 전용일 수 있다.[18]

> During his time as CEO, Philip Morris's reputation management and media relations brought together business and news interests in ways that later became controversial, with effects still debated in contemporary regulatory and legal discussions. \[attached\_file:1\]
>
> --- Hamish Maxwell 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=&diff=1316436509&oldid=)에서 발췌

Grok이 생성한 텍스트에는 인용 뒤에 XML 스타일의 `grok_card` 태그가 포함될 수 있다.

> Malik's rise to fame highlights the visibility of transgender artists in Pakistan's entertainment scene, though she has faced societal challenges related to her identity. [...] `<grok-card data-id="e8ff4f" data-type="citation_card">`
>
> --- Draft:Mehak Malik 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Draft:Mehak_Malik&oldid=)에서 발췌

**검색 링크:**
- ["contentReference" OR "oaicite" OR "oai_citation"](https://en.wikipedia.org/w/index.php?search=%22contentReference%22+OR+%22oaicite%22+OR+%22oai_citation%22&title=Special%3ASearch)

#### attribution과 attributableIndex

ChatGPT는 문장 끝에 `({"attribution":{"attributableIndex":"X-Y"}})` 형태의 JSON 형식 코드를 추가할 수 있으며, X와 Y는 증가하는 숫자 인덱스이다.

**예시:**

> ^[Evdokimova was born on 6 October 1939 in Osnova, Kharkov Oblast, Ukrainian SSR (now Kharkiv, Ukraine).]\({"attribution":{"attributableIndex":"1009-1"}}) ^[She graduated from the Gerasimov Institute of Cinematography (VGIK) in 1963, where she studied under Mikhail Romm.]\({"attribution":{"attributableIndex":"1009-2"}}) [oai\_citation:0 -- IMDb](https://www.imdb.com/name/nm0947835/?utm_source=chatgpt.com) [oai\_citation:1 -- maly.ru](https://www.maly.ru/en/people/EvdokimovaA?utm_source=chatgpt.com)
>
> --- Draft:Aleftina Evdokimova에서 발췌

> Patrick Denice & Jake Rosenfeld, Les syndicats et la remuneration non syndiquee aux Etats-Unis, 1977-2015, *Sociological Science* (2018).]\({"attribution":{"attributableIndex":"3795-0"}})
>
> --- fr:Syndicalisme aux Etats-Unis 문서의 [해당 diff](https://en.wikipedia.org/w/index.php?title=fr:Syndicalisme_aux_%C3%89tats-Unis&oldid=)에서 발췌

#### 존재하지 않거나 부적절한 카테고리

LLM은 존재하지 않는 카테고리를 환각(hallucinate)할 수 있는데, 일반적인 개념에 대해 그럴듯한 카테고리 제목(또는 SEO 키워드)처럼 보이는 경우도 있고, 학습 데이터에 폐지되거나 이름이 변경된 카테고리가 포함되어 있기 때문인 경우도 있다. 이들은 빨간색 링크(red link)로 나타난다. Category:Entrepreneurs와 같은 카테고리 리다이렉트를 발견할 수도 있는데, 이는 오랫동안 스팸 발송자들이 즐겨 사용한 것이다. 때때로 깨진 카테고리가 검토자에 의해 삭제될 수 있으므로, 페이지가 LLM에 의해 생성되었다고 의심되는 경우 이전 편집을 확인해 볼 가치가 있다.

물론, 이 섹션의 어떤 내용도 엄격한 규칙으로 취급해서는 안 된다. 새 사용자들은 이 섹션들에 대한 위키백과의 스타일 지침을 알지 못할 가능성이 높으며, 복귀한 편집자들은 이후 삭제된 이전 카테고리에 익숙할 수 있다.

**예시:**

> `[[Category:American hip hop musicians]]`
>
> --- Draft:Paytra 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Draft:Paytra&oldid=)에서 발췌

올바른 카테고리는 `[[Category:American hip-hop musicians]]`이다.

#### 존재하지 않는 템플릿

LLM은 존재하지 않는 템플릿(특히 그럴듯하게 들리는 유형의 정보상자)과 템플릿 매개변수를 환각하는 경우가 많다. 이들도 빨간색 링크로 나타나며, 기존 템플릿 내의 존재하지 않는 매개변수는 아무 효과가 없다. LLM은 학습 데이터 기준일 이후에 삭제된 템플릿(예: lang-?? 계열)을 사용할 수도 있다.

**예시:**

> ```
> {{Infobox ancient population
> | name = Gangetic Hunter-Gatherer (GHG)
> | image = [[File:GHG_reconstruction.png|250px]]
> | caption = Artistic reconstruction of a Gangetic Hunter-Gatherer male...
> | regions = Ganga Valley (from Haryana to Bengal, between the Vindhyas and Himalayas)
> | period = Mesolithic-Early Neolithic (10,000-5,000 BCE)
> | descendants = Gangetic peoples, Indus Valley Civilisation, South Indian populations
> | archaeological_sites = Bhimbetka, Sarai Nahar Rai, Mahadaha, Jhusi, Chirand
> }}
> ```
>
> --- Draft:Gangetic hunter-gatherers 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Draft:Gangetic_hunter-gatherers&oldid=)에서 발췌

올바른 템플릿:

> ```
> {{Infobox archaeological culture
> | name = Gangetic Hunter-Gatherer (GHG)
> | map = [[File:GHG_reconstruction.png|250px]]
> | mapcaption = Artistic reconstruction of a Gangetic Hunter-Gatherer male...
> | region = Ganga Valley (from Haryana to Bengal, between the Vindhyas and Himalayas)
> | period = Mesolithic-Early Neolithic (10,000-5,000 BCE)
> | followedby = Gangetic peoples, Indus Valley Civilisation, South Indian populations
> | majorsites = Bhimbetka, Sarai Nahar Rai, Mahadaha, Jhusi, Chirand
> }}
> ```

**검색 링크:**
- [Wikipedia:Database reports/Transclusions of non-existent templates](https://en.wikipedia.org/wiki/Wikipedia:Database_reports/Transclusions_of_non-existent_templates) -- 이 깨진 템플릿 중 다수는 합법적인 실수이지만, "infobox"와 "lang" 섹션에는 LLM 환각이 포함되어 있을 가능성이 높다.

### utm_source=

ChatGPT는 출처로 사용하는 URL에 UTM 매개변수 `utm_source=openai` 또는 `utm_source=chatgpt.com`을 추가할 수 있다. Microsoft Copilot은 URL에 `utm_source=copilot.com`을 추가할 수 있다. Grok은 `referrer=grok.com`을 사용한다. Gemini나 Claude 등 다른 LLM은 UTM 매개변수를 덜 자주 사용한다.[f]

참고: 이는 ChatGPT의 관여를 확정적으로 증명하지만, 그 자체로 ChatGPT가 글쓰기도 생성했음을 증명하지는 않는다. 일부 편집자는 기존 텍스트에 대한 인용을 찾기 위해 AI 도구를 사용하며, 이는 편집 기록에서 확인할 수 있다.

**예시:**

> Following their marriage, Burgess and Graham settled in Cheshire, England, where Burgess serves as the head coach for the Warrington Wolves rugby league team. \[https://www.theguardian.com/sport/2025/feb/11/sam-burgess-interview-warrington-rugby-league-luke-littler?utm\_source=chatgpt.com\]
>
> --- Sam Burgess 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=&diff=1277944793&oldid=)에서 발췌

**검색 링크:**
- [utm_source=chatgpt.com](https://en.wikipedia.org/w/index.php?search=%utm_source=chatgpt.com%22&title=Special:Search&profile=advanced&fulltext=1&ns0=1)
- [insource:"utm_source=chatgpt.com"](https://en.wikipedia.org/w/index.php?search=insource%3A%22utm_source%3Dchatgpt.com%22&title=Special%3ASearch&profile=advanced&fulltext=1&ns0=1)
- [insource:"utm_source=openai"](https://en.wikipedia.org/w/index.php?search=insource%3A%22utm_source%3Dopenai%22&title=Special%3ASearch&profile=advanced&fulltext=1&ns0=1)
- [insource:"utm_source=copilot.com"](https://en.wikipedia.org/w/index.php?search=insource%3A%22utm_source%3Dcopilot.com%22&title=Special%3ASearch&profile=advanced&fulltext=1&ns0=1)
- [insource:"referrer=grok.com"](https://en.wikipedia.org/w/index.php?search=insource%3A%22referrer%3Dgrok.com%22&title=Special%3ASearch&profile=advanced&fulltext=1&ns0=1)

### 참조(references) 섹션에 선언되었지만 문서 본문에서 사용되지 않은 이름 있는 참조

*이 섹션은 다음 내용의 추가가 필요합니다: 이 지표를 설명하는 텍스트가 여기에 추가되어야 합니다. (2025년 12월)*

**예시:**

> ```
> <references>
> <ref name="fiercebiotech">https://www.fiercebiotech.com/cro/parexel-co-founder-...</ref>
> <ref name="statnews">https://www.statnews.com/2018/03/16/parexel-josef-von-rickenbach-cro/</ref>
> <ref name="mclean">https://www.mcleanhospital.org/news/three-prominent-community-members-join-mcleans-board</ref>
> <ref name="twst">https://www.twst.com/bio/josef-h-von-rickenbach/</ref>
> </references>
> ```
>
> 결과: 네 개의 참조 모두에 대한 인용 오류 -- "A list-defined reference named '...' is not used in the content."
>
> --- Draft:Josef von Rickenbach 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Draft:Josef_von_Rickenbach&oldid=)에서 발췌

> ```
> <references>
> <ref name="wooart-about">[https://wooart.ca/about-caligomos-art About Caligomos Art - WOO ART]</ref>
> <ref name="wooart-home">[https://wooart.ca/ Home - WOO ART]</ref>
> <ref name="discover-leeds">[https://discoverdirectory.leedsgrenville.com/... Woo Art Gallery]</ref>
> <ref name="book-amazon">Woo, John HR. ''The Book of Caligomos Art''. Amazon KDP, 2025.</ref>
> </references>
> ```
>
> 결과: 네 개의 참조 모두에 대한 인용 오류.
>
> --- Draft:Caligomos Art 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Draft:Caligomos_Art&oldid=)에서 발췌

**검색 링크:**
- [Category:Pages with incorrect ref formatting](https://en.wikipedia.org/wiki/Category:Pages_with_incorrect_ref_formatting)

## 인용

*AI에 국한되지 않는 일반적인 지침은 [위키백과:허구의 참고문헌](https://en.wikipedia.org/wiki/Wikipedia:Fictitious_references)을 참고하라.*

### 깨진 외부 링크

새로운 문서나 초안에 외부 링크가 포함된 인용이 여러 개 있는데, 그중 상당수가 깨져 있다면(예: 404 오류 반환), 이는 AI 생성 페이지의 강력한 징후이다. 특히 해당 깨진 링크가 인터넷 아카이브(Internet Archive)나 아카이브 투데이(Archive Today) 같은 웹 아카이빙 사이트에서도 발견되지 않는 경우 더욱 그러하다. 대부분의 링크는 시간이 지나면 깨지기 마련이지만, 이러한 요인들은 해당 링크가 애초에 실제로 존재한 적이 없었을 가능성을 높인다.

### 유효하지 않은 DOI와 ISBN

*DOI와 ISBN에 관한 AI에 국한되지 않는 일반적인 지침은 [위키백과:DOI](https://en.wikipedia.org/wiki/Wikipedia:DOI) 및 [위키백과:ISBN](https://en.wikipedia.org/wiki/Wikipedia:ISBN)을 참고하라.*

체크섬을 사용하여 ISBN을 검증할 수 있다. 유효하지 않은 체크섬은 ISBN이 올바르지 않다는 매우 유력한 징후이며, 인용 틀은 이 경우 경고를 표시한다. 마찬가지로 DOI는 일반 하이퍼링크보다 링크 부패(link rot)에 강하다. 해석할 수 없는 DOI와 유효하지 않은 ISBN은 환각된(hallucinated) 참고문헌의 지표가 될 수 있다.

### 관련 없는 논문으로 연결되는 DOI

LLM은 존재하지 않는 학술 논문에 대한 참고문헌을 생성하면서, 유효해 보이지만 실제로는 관련 없는 논문에 할당된 DOI를 붙이는 경우가 있다. ChatGPT가 생성한 예시 문단:

> Ohm's Law applies to many materials and components that are "ohmic," meaning their resistance remains constant regardless of the applied voltage or current. However, it does not hold for non-linear devices like diodes or transistors [1][2].
>
> 1. M. E. Van Valkenburg, "The validity and limitations of Ohm's law in non-linear circuits," *Proceedings of the IEEE*, vol. 62, no. 6, pp. 769-770, Jun. 1974. [doi:10.1109/PROC.1974.9547](https://doi.org/10.1109%2FPROC.1974.9547)
>
> 2. C. L. Fortescue, "Ohm's Law in alternating current circuits," *Proceedings of the IEEE*, vol. 55, no. 11, pp. 1934-1936, Nov. 1967. [doi:10.1109/PROC.1967.6033](https://doi.org/10.1109%2FPROC.1967.6033)

두 *Proceedings of the IEEE* 인용은 완전히 조작된 것이다. DOI는 다른 인용으로 연결되며, 그 외에도 여러 문제가 있다. 예를 들어 C. L. Fortescue는 해당 논문의 추정 작성 시점에 이미 30년 이상 사망한 상태였고, [Vol 55, Issue 11](https://ieeexplore.ieee.org/xpl/tocresult.jsp?isnumber=31102&punumber=5)에는 참고문헌 2에 제시된 정보와 조금이라도 일치하는 논문이 목록에 없다.

참고: 2018년부터 2023년까지 [비주얼에디터(VisualEditor)의 UX 문제](https://phabricator.wikimedia.org/T198456)로 인해 많은 편집자들이 낮은 ID 번호의 PubMed 논문(PMID)에 대한 참고문헌을 실수로 삽입하게 되었고, 그 결과 쥐의 간에 관한 논문(PMID 9)이 2020년 디즈니 텔레비전 영화 목록에 인용되는 것과 같이 명백히 무관한 인용이 발생했다. 이것은 AI 환각과 유사해 보일 수 있으며(어떤 경우든 수정해야 하지만), 일반적으로 AI에 의한 것은 아니다.

### 페이지 번호나 URL이 없는 도서 인용

LLM은 페이지 번호가 포함되지 않은 도서 인용을 생성하는 경우가 많다. 예를 들어 다음 문단은 ChatGPT가 생성한 것이다:

> Ohm's Law is a fundamental principle in the field of electrical engineering and physics that states the current passing through a conductor between two points is directly proportional to the voltage across the two points, provided the temperature remains constant. Mathematically, it is expressed as V=IR, where V is the voltage, I is the current, and R is the resistance. The law was formulated by German physicist Georg Simon Ohm in 1827, and it serves as a cornerstone in the analysis and design of electrical circuits [1].
>
> 1. Dorf, R. C., & Svoboda, J. A. (2010). *Introduction to Electric Circuits* (8th ed.). Hoboken, NJ: John Wiley & Sons. ISBN 9780470521571.

해당 도서 참고문헌은 유효해 보인다 -- 전기 회로에 관한 책이라면 옴의 법칙에 대한 정보가 있을 것이다 -- 그러나 페이지 번호가 없으면 해당 인용은 본문의 주장을 검증하는 데 유용하지 않다.

일부 LLM이 생성한 도서 인용에는 페이지 번호가 포함되어 있고 해당 도서도 실제로 존재하지만, 인용된 페이지가 실제로 본문의 내용을 뒷받침하지 않는 경우가 있다. 주의할 점: 해당 도서가 다소 일반적인 주제를 다루거나 해당 분야에서 자주 인용되는 책이며, 인용에 URL이 포함되어 있지 않은 경우이다(URL은 도서 인용에 필수는 아니지만, 정당한 도서 인용을 작성하는 편집자들은 온라인 버전 링크를 포함하는 경우가 많다). 예시:

> Analysts note that traditionalists often appeal to prudence, stability, and Edmund Burke's notion of "prescription," while reactionaries invoke moral urgency and cultural emergency, framing the present as a deviation from an idealized past. [1]
>
> 1. Goldwater, Barry (1960). *The Conscience of a Conservative*. Victor Publishing. p. 12.

이것은 합리적인 인용처럼 보일 수 있지만, [해당 도서의 온라인 버전에서 "Burke"를 검색하면 결과가 나오지 않는다](https://www.google.com/books/edition/The_Conscience_of_a_Conservative/PKd_EQAAQBAJ?hl=en&gbpv=1&bsq=burke).

### 참고문헌의 부정확하거나 비관습적인 사용

AI 도구에 참고문헌을 포함하라는 프롬프트가 주어질 수 있으며, 위키백과가 기대하는 방식으로 참고문헌을 포함하려고 시도하지만, 일부 핵심적인 구현 세부사항에서 실패하거나 관례와 비교했을 때 눈에 띄게 된다.

**예시:**

아래 예시에서 참고문헌 재사용 시도가 잘못된 것에 주목하라. 여기서 사용된 도구는 조작되지 않은 출처를 검색할 수 있는 기능이 없었지만(빙 딥 서치(Bing Deep Search)가 출시되기 하루 전에 수행되었기 때문에), 그럼에도 불구하고 하나의 실제 참고문헌을 찾아냈다. 참고문헌 재사용을 위한 구문이 잘못되었다.

이 경우 Smith, R. J. 출처는 -- 도구가 추정컨대 생성한 링크 'https://pubmed.ncbi.nlm.nih.gov/3'(PMID 참조 번호 3)의 "세 번째 출처"로서 -- 문서의 본문과도 완전히 무관하다. 사용자는 링크가 해석되기는 하지만, 참고문헌을 {{cite journal}} 참고문헌으로 변환하기 전에 확인하지 않았다.

이 경우 LLM은 모든 마침표 뒤에 잘못된 재사용 구문을 성실하게 삽입했다.

> For over thirty years, computers have been utilized in the rehabilitation of individuals with brain injuries. Initially, researchers delved into the potential of developing a "prosthetic memory."[ref: Fowler R, Hart J, Sheehan M. ...] However, by the early 1980s, the focus shifted towards addressing brain dysfunction through repetitive practice.[ref: Smith, R. J.; Bryant, R. G. "Metal substitutions in carbonic anhydrase: a halide ion probe study" ...] Only a few psychologists were developing rehabilitation software for individuals with Traumatic Brain Injury (TBI), resulting in a scarcity of available programs.[3] Cognitive rehabilitation specialists opted for commercially available computer games [...][3]
>
> --- Cognitive orthotics 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Cognitive_orthotics&oldid=)에서 발췌

일부 LLM 또는 챗봇 인터페이스는 각주를 나타내기 위해 "&#8617;" 문자를 사용한다:

> References
>
> Would you like help formatting and submitting this to Wikipedia, or do you plan to post it yourself? I can guide you step-by-step through that too.
>
> Footnotes
>
> 1. KLAS Research. (2024). Top Performing RCM Vendors 2024. https://klasresearch.com &#8617; &#8617;2
>
> 2. PR Newswire. (2025, February 18). CureMD AI Scribe Launch Announcement. https://www.prnewswire.com/news-releases/curemd-ai-scribe &#8617;
>
> --- Draft:CureMD 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Draft:CureMD&oldid=)에서 발췌

---

## 기타

### 갑작스러운 문체 변화

편집자의 문체가 갑자기 변하는 것, 예를 들어 다른 의사소통에 비해 예상치 못하게 완벽한 문법을 사용하는 것은 AI 도구 사용을 나타낼 수 있다. 격식체와 비격식체의 혼용은 AI에만 국한된 것은 아니지만, 하나의 징후로 간주될 수 있다. 특정 글쓰기에서 더 격식 있는 문체를 사용하는 것은 단순히 코드 스위칭(code switching)의 문제일 수 있다.

사용자의 위치, 주제와 관련된 국가적 연관성에 따른 영어 변종, 그리고 실제 사용된 영어 변종 사이의 불일치는 AI 도구 사용을 나타낼 수 있다. 인도에서 인도 대학에 대해 글을 쓰는 인간 필자라면 아마도 미국 영어를 사용하지 않을 것이다. 그러나 LLM에 따라 별도의 프롬프트가 없는 한 미국 영어가 기본으로 사용될 수 있다.[19] 비원어민 영어 화자는 영어 변종을 혼용하는 경향이 있으므로, 이러한 징후는 편집자의 영어 변종 사용이 갑작스럽고 완전하게 바뀌는 경우에만 의심을 제기해야 한다. 또한 미국 영어의 일부 표준 요소가 영국 영어에서는 흔한 변형이며, 그 반대도 마찬가지라는 점에 유의할 필요가 있다. 여기에는 집합명사를 복수로 취급하거나 "one hundred and one"(101)에 "and"를 포함하는 것 등이 있다.

### 지나치게 장황한 편집 요약

AI가 생성한 편집 요약은 비정상적으로 길고, 약어 없이 격식체의 1인칭 문단으로 작성되며, 위키백과의 관례를 눈에 띄게 항목화하는 경우가 많다.

**예시:**

> ChatGPT I revised the content to provide a neutral and informative description of the Indira Gandhi National Centre for the Arts (IGNCA). The focus was on presenting the institution's objectives, approach, and programs in a way that adheres to Wikipedia's guidelines. The tone was adjusted to be more encyclopedic and less promotional.
>
> --- Indira Gandhi National Centre for the Arts 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Indira_Gandhi_National_Centre_for_the_Arts&oldid=)에서 발췌한 편집 요약

> I formalized the tone, clarified technical content, ensured neutrality, and indicated citation needs. Historical narratives were streamlined, allocation details specified with regulatory references, propagation explanations made reader-friendly, and equipment discussions focused on availability and regulatory compliance, all while adhering to encyclopedic standards.
>
> --- 4-metre band 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=4-metre_band&oldid=)에서 발췌한 편집 요약

> \*\*Concise edit summary:\*\* Improved clarity, flow, and readability of the plot section; reduced redundancy and refined tone for better encyclopedic style.
>
> --- Anaganaga (film) 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Anaganaga_(film)&oldid=)에서 발췌한 편집 요약

### AFC 초안의 "제출 설명문"

이 항목은 문서 작성 요청(Articles for Creation)을 통해 제출된 초안에 한정된다. 최소 하나의 LLM은 검토자를 위한 것으로 추정되는 "제출 설명문"을 삽입하는 경향이 있는데, 이 설명문은 해당 주제가 왜 주목할 만한지, 그리고 초안이 왜 위키백과 지침을 충족하는지를 설명하려 한다. 물론 실제로 이것이 하는 일은 검토자에게 해당 초안이 LLM으로 생성되었음을 알려주는 것이며, 더 이상의 검토 없이 거절되거나 신속 삭제되어야 한다.

**예시:**

> Reviewer note (for AfC): This draft is a neutral and well-sourced biography of Portuguese public manager Jorge Patrao. All references are from independent, reliable sources (Publico, Diario de Noticias, Jornal de Negocios, RTP, O Interior, Agencia Lusa) covering his public career and cultural activity. It meets WP:RS and WP:BLP standards and demonstrates clear notability per WP:NBIO through: -- Presidency of Serra da Estrela Tourism Region (1998-2013); -- Presidency of Parkurbis -- Covilha Science and Technology Park; -- Founding role in Rede de Judiarias de Portugal (member of the Council of Europe's European Routes of Jewish Heritage); -- Authorship of the book "1677 -- A Fabrica d'El-Rei"; -- Founder/curator of the Beatriz de Luna Art Collection (Old Master focus). There is also a Portuguese version of this article at pt.wikipedia.org/wiki/Jorge_Patrao. Thank you for your review. -->
>
> --- Draft:Jorge Patrao 상단에서 발견됨 (불가피한 서식 오류는 모두 원문 그대로임)

### 사전 배치된 유지보수 틀

간혹 신규 편집자가 이미 "거절됨"으로 설정된 AFC 검토 틀이 포함된 초안을 작성하는 경우가 있다. 해당 틀에는 검토자의 거절 사유도 없이 내용이 비어 있다. LLM이 초안에 AFC 제출 틀을 추가해 주겠다고 제안한 후 `{{AfC submission|d}}`와 같은 것을 제공한 것으로 보이며, 여기서 "d" 매개변수는 `{{AfC submission/declined}}`를 대체하여 초안을 사전 거절한다. 해당 초안의 기여 이력을 보면 이 틀이 초안 작성자에 의해 삽입된 것임을 알 수 있다. 작성자는 이후 위키백과:위키프로젝트 문서 작성 요청/도움말 게시판이나 다른 도움말 페이지에서 왜 초안이 피드백 없이 거절되었는지 질문하게 된다. 내용 없는 "제출 거절됨" 헤더의 존재는 해당 초안이 LLM으로 생성되었다는 강력한 지표이다.

LLM은 유지보수 태그와 잘못된 보호 틀을 포함하여, 합리적으로 존재해서는 안 되는 유지보수 틀이 이미 포함된 페이지를 생성하는 것으로 알려져 있다.

**예시:**

> ```
> {{Short description|French inventor and engineer (1861-1942)}}
> {{pp|small=yes}}
> {{pp-move}}
> {{Use American English|date=September 2022}}
> {{Use mdy dates|date=February 2025}}
> ```
>
> --- 사용자 샌드박스(이후 Emile Dufresne로 잘라내기-붙여넣기 이동됨)의 [해당 편집](https://en.wikipedia.org/w/index.php?title=User:&oldid=)에서 발췌

**검색 링크:**
- ["you declined your own draft"](https://en.wikipedia.org/w/index.php?search=%22you+declined+your+own+draft%22&title=Special%3ASearch&profile=advanced&fulltext=1&ns4=1&ns118=1)

---

## 인간이 작성한 글의 징후

### ChatGPT 출시 대비 텍스트의 연령

ChatGPT는 2022년 11월 30일에 대중에게 공개되었다. OpenAI는 그 이전에도 유사한 성능의 LLM을 보유하고 있었지만, 유료 서비스였고 일반인이 쉽게 접근하거나 알기 어려웠다. 따라서 2022년 11월 30일 이전에 이루어진 편집의 경우, 해당 텍스트에 대한 AI 사용은 안전하게 배제할 수 있다. 일부 오래된 글이 이 목록에 제시된 AI 징후 중 일부를 보이거나 심지어 AI가 생성한 것처럼 설득력 있게 보일 수 있지만, 위키백과의 방대한 규모를 고려하면 이러한 우연의 일치는 충분히 가능하다.

### 자신의 편집 선택을 설명할 수 있는 능력

편집자는 자신이 왜 특정 편집이나 실수를 했는지 설명할 수 있어야 한다. 예를 들어 편집자가 조작된 것으로 보이는 URL을 삽입한 경우, 성급한 결론을 내리기보다는 어떻게 그런 혼동이 발생했는지 물어볼 수 있다. 편집자가 올바른 링크를 제공하고 이를 인적 오류(아마도 오타)로 설명하거나, 실제 출처의 관련 구절을 공유할 수 있다면, 이는 일반적인 인적 오류를 가리킨다.

---

## 효과 없는 지표

AI 사용에 대한 거짓 비난은 신규 편집자를 내쫓고 의심의 분위기를 조성할 수 있다. AI가 사용되었다고 주장하기 전에, 더닝-크루거 효과(Dunning-Kruger effect)와 확증 편향(confirmation bias)이 판단을 흐리고 있지는 않은지 고려하라. 다음은 LLM 탐지에 효과가 없는, 다소 흔하게 사용되는 지표들이다 -- 오히려 반대를 나타낼 수도 있다.

**완벽한 문법:** 현대 LLM은 높은 문법적 능숙도로 알려져 있지만, 많은 편집자 역시 능숙한 필자이거나 전문 글쓰기 배경을 가지고 있다. (참고: 갑작스러운 영어 변종 사용의 변화.)

**격식체와 비격식체의 혼용, 또는 "임상적"이면서도 "감정적"으로 들리는 언어:** 이것은 컴퓨터 과학과 같은 기술 분야에 종사하는 사람의 평상시 글쓰기를 나타낼 수 있다. 또한 젊음, 혼합된 문체에 대한 선호, 장난기, 또는 신경다양성(neurodivergence)을 나타낼 수도 있다. 위키의 경우, 단순히 여러 편집자가 한 페이지에 기여한 결과일 수도 있다.

**"밋밋한" 또는 "로봇 같은" 문장:** LLM 출력은 위에서 상세히 설명한 것처럼 특정한 특성을 가지며, 기본적으로 긍정적이고 장황한 방향으로 치우친다. 이러한 경향은 정형화되어 있지만, AI 글쓰기에 익숙하지 않은 사람들에게는 "로봇 같다"고 느껴지지 않을 수 있다.[20]

**"화려한", "학술적인" 또는 "격식 있는" 문장:** LLM은 특정 단어와 구문을 불균형적으로 선호하며, 그중 다수는 일부 동의어보다 더 길고 가독성 점수가 더 어려운 것이 사실이지만, 이들은 특정 단어에 해당한다. 이러한 상관관계가 모든 격식적, 학술적 또는 "화려하게" 들리는 문장으로 확장되지는 않는다.[1]

**편지 형식의 글쓰기 (단독으로):** 2023년 이후에 인사말, 맺음말, 제목줄 및 기타 격식을 갖춘 토론 페이지 메시지는 AI가 생성한 것처럼 보이는 경향이 있지만, 편지와 이메일은 현대 LLM이 존재하기 훨씬 전부터 관례적으로 그러한 방식으로 작성되어 왔다. 인간 편집자(특히 신규 편집자)는 공식적인 의사소통에 더 익숙하거나, 이러한 어조를 요구하는 학교 과제의 일부로 게시하거나, 단순히 토론 페이지를 이메일로 착각하는 등 다양한 이유로 토론 페이지 댓글을 유사하게 구성할 수 있다. 수직 목록[g], 플레이스홀더, 또는 갑작스러운 중단 같은 다른 징후가 더 강력하다.

**접속사/전환어 (단독으로):** 이전 AI 텍스트는 *Additionally*, *Consequently*, *Notably* 같은 특정 전환어를 정형화된 방식으로 과도하게 사용하는 경향이 있었으며, 흔히 문장을 시작하는 데 사용했다. 그러나 이런 방식으로 AI가 과용하는 것으로 알려진 전환어와 구문은 소수에 불과하다. 이 패턴은 인간의 에세이 형식 글쓰기에서도 선례가 있으며 많은 문체 지침에서 허용하고 있으므로, 강력한 징후가 아니다.

**출처 없는 내용:** 570,000개 이상의 문서가 인용이 필요한 것으로 태그되어 있으며, 대부분은 LLM 이전에 작성된 것이다. 한편, 현대 LLM 챗봇은 웹을 검색하거나 사용자가 제공한 출처를 볼 수 있으므로, AI가 생성한 텍스트에도 인용이 상당히 흔하게 포함된다. 이것이 정확한 인용이라는 뜻은 아니지만, 존재하기는 한다.

**비정상적인 위키텍스트:** LLM은 "마크다운 사용"에서 설명한 이유로 틀을 환각하거나 유효하지 않은 구문의 위키텍스트 코드를 생성할 수 있지만, "마크업"에 나열된 것을 제외한 특정한 무작위적이고 "설명할 수 없는" 오류와 아티팩트가 포함된 콘텐츠를 생성할 가능성은 낮다. `<span>`과 같이 이상하게 배치된 HTML 태그는 잘못 프로그래밍된 브라우저 확장 프로그램이나 위키백과의 콘텐츠 번역 도구의 알려진 버그(T113137)를 더 강하게 나타낸다. `''Catch-22 i''s a satirical novel.`("*Catch-22 i*s a satirical novel."로 렌더링됨)과 같은 잘못 배치된 구문은 소스 편집에서보다 이러한 오류를 발견하기 어려운 비주얼에디터에서의 실수를 더 강하게 나타낸다.

---

## 역사적 지표

다음 지표들은 이전 AI 모델이 생성한 텍스트에서 흔했지만, 최신 모델에서는 훨씬 덜 빈번하다. 이전에 탐지되지 않은 오래된 AI 생성 편집을 찾는 데는 여전히 유용할 수 있다. 날짜는 대략적이다.

### 교훈적 면책 조항 (2022-2024)

*AI에 국한되지 않는 일반적인 지침은 [위키백과:편집 지침/주의할 단어 § 사설화](https://en.wikipedia.org/wiki/Wikipedia:Manual_of_Style/Words_to_watch#Editorializing)를 참고하라.*

**주의할 단어:** *it's important/critical/crucial to note/remember/consider, worth noting, may vary...*

이전 LLM(약 2023년)은 특정 주제가 "주목할 만한 중요한 사항"이라는 면책 조항을 자주 추가했다.[21] 이것은 흔히 안전 또는 논란이 되는 주제에 관해 상상 속의 독자에게 조언하는 형태를 취했으며, 다른 지역/관할권에서 달라지는 주제를 명확히 구분하는 형태를 취하기도 했다. 이러한 면책 조항 중 여러 개가 OpenAI의 GPT-4 시스템 카드에 "부분 거부"의 예시로 나타난다.[22]

**예시:**

> The emergence of these informal groups reflects a growing recognition of the interconnected nature of urban issues and the potential for ANCs to play a role in shaping citywide policies. However, it's important to note that these caucuses operate outside the formal ANC structure and their influence on policy decisions may vary.
>
> --- Advisory Neighborhood Commission 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Advisory_Neighborhood_Commission&oldid=)에서 발췌

> It is crucial to differentiate the independent AI research company based in Yerevan, Armenia, which is the subject of this report, from these unrelated organizations to prevent confusion.
>
> --- Draft:Robi Labs에서 발췌

> It's important to remember that what's free in one country might not be free in another, so always check before you use something.
>
> --- 위키미디어의 Public domain에 대한 [LLM 생성 간단 요약](https://gitlab.wikimedia.org/repos/web/web-experiments-extension/-/commit/55fdbbb3decdc9b95ae0ef00e98b1108ddc3a498.diff)에서 발췌

### 섹션 요약

**주의할 단어:** *In summary, In conclusion, Overall ...*

더 긴 출력을 생성할 때("문서를 작성하라"는 지시를 받은 경우 등), 이전 LLM은 "결론(Conclusion)" 또는 유사한 제목의 섹션을 자주 추가했으며, 문단이나 섹션의 끝에서 핵심 아이디어를 요약하고 재진술하는 경우가 많았다.[19]

**예시:**

> In summary, the educational and training trajectory for nurse scientists typically involves a progression from a master's degree in nursing to a Doctor of Philosophy in Nursing, followed by postdoctoral training in nursing research. This structured pathway ensures that nurse scientists acquire the necessary knowledge and skills to engage in rigorous research and contribute meaningfully to the advancement of nursing science.
>
> --- Nurse scientist 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=&diff=1188230584&oldid=)에서 발췌

### 프롬프트 거부

**주의할 단어:** *as an AI language model, as a large language model, I cannot offer medical advice, but I can..., I'm sorry ...*

과거에 AI 챗봇은 작성된 프롬프트에 대한 답변을 거부하는 경우가 있었으며, 대개 사과와 함께 자신이 AI 언어 모델이라는 점을 상기시켜 주었다. 도움이 되고자 하는 의도로, 챗봇은 대안적이거나 유사한 요청에 대한 제안이나 답변을 제공하는 경우가 많았다. 완전한 거부는 점점 더 드물어지고 있다. Gemini 3.0은 때때로 비속어를 사용하기도 한다.

**예시:**

> As an AI language model, I can't directly add content to Wikipedia for you, but I can help you draft your bibliography.
>
> --- Parmiter's Almshouse & Pension Charity 문서의 [해당 편집](https://en.wikipedia.org/w/index.php?title=Parmiter%27s_Almshouse_%26_Pension_Charity&oldid=)에서 발췌

### 갑작스러운 중단

AI 도구는 단일 응답에 과도한 수의 토큰이 사용되면 콘텐츠 생성을 갑작스럽게 중단했으며, 추가 응답을 위해서는 사용자가 "계속 생성(continue generating)"을 선택해야 했다. 적어도 ChatGPT의 경우에는 그러했다.

이 방법은 완벽하지 않다. 로컬 컴퓨터에서의 잘못된 복사/붙여넣기도 이와 같은 현상을 일으킬 수 있기 때문이다. 이는 LLM 사용보다는 저작권 침해를 나타낼 수도 있다.

### 오래된 접근일(access-date) 매개변수

일부 AI 지원 텍스트에서 인용은 기본적으로 접근일을 포함할 수 있지만, 편집이 이루어진 시점에 비해 날짜가 예상외로 오래된 경우가 있다(예: 2025년 12월에 생성된 문서에 `|access-date=12 December 2024`가 포함된 인용이 여러 개 있는 경우). 그러나 최신 챗봇은 이 오류를 거의 발생시키지 않으며, 오래된 접근일 값은 정당하게 발생할 수 있다(인용 복사, 오프라인 작업, 일괄 이동/병합 등).

---

## 같이 보기

- [위키백과:인공지능 자료](https://en.wikipedia.org/wiki/Wikipedia:Artificial_intelligence_resources)
- [위키백과:인공지능](https://en.wikipedia.org/wiki/Wikipedia:Artificial_intelligence)
- [위키백과:LLM 차단 해제 요청 식별](https://en.wikipedia.org/wiki/Wikipedia:Identifying_LLM_unblock_requests)

---

## 주석

a. 구체적으로, 이 지침은 "건조한 학술적" 글쓰기가 아닌 텍스트에는 덜 유용하다. 예를 들어, 소설에 특유한 많은 징후(속삭이는 숲, [Elara Voss](https://maxread.substack.com/p/who-is-elara-voss) 등)는 위키백과에서는 관련성이 낮으며 여기에 나열되지 않았다.

b. 이는 텍스트-이미지 생성 모델이 생성한 이미지를 검토하면 직접 관찰할 수 있다. 이미지는 처음 보기에는 괜찮아 보이지만, 세부 사항이 흐릿하고 기형적인 경향이 있다. 이는 특히 배경 객체와 텍스트에서 두드러진다.

c. AI 챗봇에만 고유한 것은 아니며, {{as of}} 틀에 의해서도 생성된다.

d. 예시 (삭제됨, 관리자만 열람 가능).

e. 초안의 ```wikitext 예시.

f. T387903 참고.

g. 삭제 토론에서의 수직 목록 예시.

---

## 참고문헌

1. Russell, Jenna; Karpinska, Marzena; Iyyer, Mohit (2025). [People who frequently use ChatGPT for writing tasks are accurate and robust detectors of AI-generated text](https://aclanthology.org/2025.acl-long.267/). *Proceedings of the 63rd Annual Meeting of the Association for Computational Linguistics (Volume 1: Long Papers)*. Vienna, Austria: Association for Computational Linguistics. pp. 5342-5373. [arXiv:2501.15654](https://arxiv.org/abs/2501.15654). [doi:10.18653/v1/2025.acl-long.267](https://doi.org/10.18653%2Fv1%2F2025.acl-long.267). [Archived](https://web.archive.org/web/20250829184825/https://aclanthology.org/2025.acl-long.267/) from the original on August 29, 2025. Retrieved September 5, 2025 -- via ACL Anthology.

2. Dugan, Liam; Hwang, Alyssa; Trhlik, Filip; Zhu, Andrew; Ludan, Josh Magnus; Xu, Hainiu; Ippolito, Daphne; Callison-Burch, Chris (2024). [RAID: A Shared Benchmark for Robust Evaluation of Machine-Generated Text Detectors](https://aclanthology.org/2024.acl-long.674). *Proceedings of the 62nd Annual Meeting of the Association for Computational Linguistics (Volume 1: Long Papers)*. Bangkok, Thailand: Association for Computational Linguistics. pp. 12463-12492. [arXiv:2405.07940](https://arxiv.org/abs/2405.07940). [Archived](https://web.archive.org/web/20250824132743/https://aclanthology.org/2024.acl-long.674/) from the original on August 24, 2025. Retrieved November 8, 2025.

3. Rudnicka, Karolina (July 9, 2025). "[Each AI chatbot has its own, distinctive writing style -- just as humans do](https://www.scientificamerican.com/article/chatgpt-and-gemini-ai-have-uniquely-different-writing-styles)". *Scientific American*. Retrieved January 18, 2026.

4. "[10 Ways AI Is Ruining Your Students' Writing](https://www.chronicle.com/article/10-ways-ai-is-ruining-your-students-writing)". *Chronicle of Higher Education*. September 16, 2025. [Archived](https://web.archive.org/web/20251001071208/https://www.chronicle.com/article/10-ways-ai-is-ruining-your-students-writing/) from the original on October 1, 2025. Retrieved October 1, 2025.

5. Juzek, Tom S.; Ward, Zina B. (2025). [Why Does ChatGPT "Delve" So Much? Exploring the Sources of Lexical Overrepresentation in Large Language Models](https://aclanthology.org/2025.coling-main.426.pdf) (PDF). *Findings of the Association for Computational Linguistics: ACL 2025*. Association for Computational Linguistics. [arXiv:2412.11385](https://arxiv.org/abs/2412.11385). [Archived](https://web.archive.org/web/20250121111136/https://aclanthology.org/2025.coling-main.426.pdf) (PDF) from the original on January 21, 2025. Retrieved October 13, 2025 -- via ACL Anthology.

6. Reinhart, Alex; Markey, Ben; Laudenbach, Michael; Pantusen, Kachatad; Yurko, Ronald; Weinberg, Gordon; Brown, David West (February 25, 2025). "[Do LLMs write like humans? Variation in grammatical and rhetorical styles](https://pnas.org/doi/10.1073/pnas.2422455122)". *Proceedings of the National Academy of Sciences*. 122 (8). [doi:10.1073/pnas.2422455122](https://doi.org/10.1073%2Fpnas.2422455122). ISSN [0027-8424](https://search.worldcat.org/issn/0027-8424). PMC [11874169](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC11874169). Retrieved January 29, 2026.

7. Geng, Mingmeng; Trotta, Roberto. "[Human-LLM Coevolution: Evidence from Academic Writing](https://aclanthology.org/2025.findings-acl.657.pdf)" (PDF). aclanthology.org. Retrieved December 17, 2025.

8. Kobak, Dmitry; Gonzalez-Marquez, Rita; Horvat, Emoke-Agnes; Lause, Jan (July 2, 2025). "[Delving into LLM-assisted writing in biomedical publications through excess vocabulary](https://www.science.org/doi/10.1126/sciadv.adt3813)". *Science Advances*. 11 (27). [doi:10.1126/sciadv.adt3813](https://doi.org/10.1126%2Fsciadv.adt3813). ISSN [2375-2548](https://search.worldcat.org/issn/2375-2548). PMC [12219543](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC12219543). PMID [40601754](https://pubmed.ncbi.nlm.nih.gov/40601754). Retrieved November 21, 2025.

9. Juzek, Tom S.; Ward, Zina B. "[Word Overuse and Alignment in Large Language Models: The Influence of Learning from Human Feedback](https://arxiv.org/pdf/2508.01930)". Retrieved February 27, 2026.

10. Kriss, Sam (December 3, 2025). "[Why Does A.I. Write Like ... That?](https://www.nytimes.com/2025/12/03/magazine/chatbot-writing-style.html)". *The New York Times*. Retrieved December 6, 2025.

11. Kousha, Kayvan; Thelwall, Mike (2025). [How much are LLMs changing the language of academic papers after ChatGPT? A multi-database and full text analysis](https://arxiv.org/pdf/2509.09596). *ISSI 2025 Conference*. [arXiv:2509.09596](https://arxiv.org/abs/2509.09596). [Archived](https://web.archive.org/web/20250914165435/https://arxiv.org/pdf/2509.09596) from the original on September 14, 2025. Retrieved November 4, 2025.

12. Merrill, Jeremy B.; Chen, Szu Yu; Kumer, Emma (November 13, 2025). "[What are the clues that ChatGPT wrote something? We analyzed its style](https://www.washingtonpost.com/technology/interactive/2025/how-detect-chatgpt-em-dash/)". *The Washington Post*. Retrieved November 14, 2025.

13. Geng, Mingmeng; Trotta, Roberto. "[Is ChatGPT Transforming Academics' Writing Style?](https://arxiv.org/abs/2404.08627)". Retrieved January 8, 2026.

14. Robbins, Hollis. "[How to Tell if Something is AI Written](https://hollisrobbinsanecdotal.substack.com/p/how-to-tell-if-something-is-ai-written)". *Anecdotal Value*. Substack. Retrieved December 7, 2025.

15. "[My synonym hell](https://www.theguardian.com/media/mind-your-language/2010/jun/02/my-synonym-hell-mind-your-language)". *Mind your language*. The Guardian. June 2, 2010. Retrieved September 30, 2011.

16. Edwards, Benj (November 14, 2025). "[Forget AGI -- Sam Altman celebrates ChatGPT finally following em dash formatting rules](https://arstechnica.com/ai/2025/11/forget-agi-sam-altman-celebrates-chatgpt-finally-following-em-dash-formatting-rules/)". *Ars Technica*. Retrieved February 24, 2026.

17. "[System Prompts](https://platform.claude.com/docs/en/release-notes/system-prompts#claude-sonnet-3-5)". *Claude Docs*. Anthropic. Retrieved January 9, 2026.

18. "[Unproductive Interpretation of Work and Employment as Misinformation?](https://www.laetusinpraesens.org/docs20s/workeco.php)". [Archived](https://web.archive.org/web/20250902133810/https://www.laetusinpraesens.org/docs20s/workeco.php) from the original on September 2, 2025. Retrieved October 21, 2025.

19. Ju, Da; Blix, Hagen; Williams, Adina (2025). [Domain Regeneration: How well do LLMs match syntactic properties of text domains?](https://aclanthology.org/2025.findings-acl.120) *Findings of the Association for Computational Linguistics: ACL 2025*. Vienna, Austria: Association for Computational Linguistics. pp. 2367-2388. [arXiv:2505.07784](https://arxiv.org/abs/2505.07784). [doi:10.18653/v1/2025.findings-acl.120](https://doi.org/10.18653%2Fv1%2F2025.findings-acl.120). [Archived](https://web.archive.org/web/20250815014117/https://aclanthology.org/2025.findings-acl.120/) from the original on August 15, 2025. Retrieved October 4, 2025 -- via ACL Anthology.

20. Murray, Nathan; Tersigni, Elisa (July 21, 2024). "[Can instructors detect AI-generated papers? Postsecondary writing instructor knowledge and perceptions of AI](https://journals.sfu.ca/jalt/index.php/jalt/article/view/1895)". *Journal of Applied Learning & Teaching*. 7 (2). [doi:10.37074/jalt.2024.7.2.12](https://doi.org/10.37074%2Fjalt.2024.7.2.12). ISSN [2591-801X](https://search.worldcat.org/issn/2591-801X). Retrieved November 21, 2025.

21. Spero, Max; Emi, Bradley. "[Technical Report on the Pangram AI-Generated Text Classifier](https://arxiv.org/abs/2402.14873)". Arxiv. Retrieved February 6, 2026.

22. "[GPT-4 System Card](https://cdn.openai.com/papers/gpt-4-system-card.pdf)" (PDF). OpenAI. Retrieved December 16, 2025.

---

## 더 읽을거리

- Kriss, Sam (December 3, 2025). "[Why Does A.I. Write Like ... That?](https://www.nytimes.com/2025/12/03/magazine/chatbot-writing-style.html)". *The New York Times Magazine*. Retrieved December 6, 2025.

---

## 외부 링크

- [Can You Pass the Turing Test?](https://canyoupasstheturingtest.com/)
- [Tropes - AI Writing Pattern Directory](https://tropes.fyi/directory)

---

*"https://en.wikipedia.org/w/index.php?title=Wikipedia:Signs_of_AI_writing&oldid=1346339233"에서 가져옴*
