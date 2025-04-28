import streamlit as st
st.title('Meu novo site')

product_name = st.text_input("Seu nome")
description = st.text_area("Comentário")

if st.button("Enviar comentário"):
    st.success("Comentário salvo com sucesso")
