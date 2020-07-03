
from wordcloud import WordCloud,ImageColorGenerator
import matplotlib.pyplot as plt 
import numpy as np
import scipy.misc
from PIL import Image
import json


import base64
import io


def text_to_wordcloud(text):
    p='''Declarative visualization grammars can accelerate development, 
    facilitate retargeting across platforms, and allow language-level optimizations.
    However, existing declarative visualization languages are primarily concerned with 
    visual encoding, and rely on imperative event handlers for interactive behaviors. 
    In response, we introduce a model of declarative interaction design for data visualizations. 
    Adopting methods from reactive programming, we model low-level events as composable data 
    streams from which we form higher-level semantic signals. Signals feed predicates and scale 
    inversions, which allow us to generalize interactive selections at the level of item geometry
     into interactive queries over the data domain. Production rules then use these queries to manipulate
      the visualization’s appearance. To facilitate reuse and sharing, these constructs can be encapsulated 
      as named interactors: standalone, purely declarative specifications of interaction techniques. We 
      assess our model’s feasibility and expressivity by instantiating it with extensions to the Vega
       visualization grammar. Through a diverse range of examples, we demonstrate coverage over an established 
       taxonomy of visualization interaction techniques.We present Reactive Vega, a system architecture that
        provides the first robust and comprehensive treatment of declarative visual and interaction design for 
        data visualization. Starting fr'''
        
    if(text is "Check Data" or len(text)==0):
        text=p
    # maskArray = np.array(Image.open("mask2.png"))
    
    # cloud = WordCloud(background_color = "white",width=480, height=480, max_words=30,mask=maskArray)
    # cloud.generate(text)
    # cloud.to_file("foo.png") 

    # plt.figure() 
    # plt.imshow(cloud, interpolation="bilinear") 
    # plt.axis("off") 
    # plt.margins(x=0, y=0) 
    # plt.show() 


    from PIL import Image

    col = Image.open("mask2.png")
    gray = col.convert('L')

# Let numpy do the heavy lifting for converting pixels to pure black or white
    bw = np.asarray(gray).copy()

# Pixel range is 0...255, 256/2 = 128
    bw[bw < 128] = 0    # Black
    bw[bw >= 128] = 255 # White

# Now we put it back in Pillow/PIL land
    imfile = Image.fromarray(bw)
    imfile.save("maskx.jpeg")

    mask1 = np.array(Image.open("maskx.jpeg"))
    mask2=np.invert(mask1)
    color_image=np.array(Image.open("colored_colors.jpg"))
    wc = WordCloud(background_color="white", max_words=1000, mask=mask1,
               max_font_size=90,random_state=5)
    wc.generate(text)
    wc_i= WordCloud(background_color="white", max_words=1000, mask=mask2,
               max_font_size=90,random_state=5)
    wc_i.generate(text)
    wc.to_file("cloud.png")
    wc_i.to_file("cloud_invert.png")
    
    
    #image_colors = ImageColorGenerator(colors)

    # figx,(a1,a2)=plt.subplots(1,2,figsize=(7,7))
    # a1.imshow(wc)
    # a2.imshow(wc_i)
# create coloring from image
    # plt.figure(figsize=[7,7])
    # plt.imshow(wc.recolor(color_func=image_colors), interpolation="bilinear")
    # plt.axis("off")
    _=plt.show()
    # plt.plot([1, 2])
    # plt.title("test")
    #buf = io.BytesIO()
    #plt.savefig("foo.jpeg")
    
    #buf.seek(0)

    #im = Image.open(buf)
    # matrix=np.array(im) 
 
    with open("cloud.png",'rb') as f:
        image64=base64.b64encode(f.read())
    image_string=image64.decode('utf-8')
    
    with open("cloud_invert.png",'rb') as f:
        image64=base64.b64encode(f.read())
    image_string_invert=image64.decode('utf-8')
    
    


    #buf.close()

    # np.save(buf, matrix)
    # buf.seek(0)
    # k=buf.read()
    # serialized = json.dumps(buf.read())
    # return serialized
    #print(len(serialized))
    return (image_string,image_string_invert)

    
# data = {}
# with open('some.gif', mode='rb') as file:
#     img = file.read()

print(text_to_wordcloud("")[0][:10])