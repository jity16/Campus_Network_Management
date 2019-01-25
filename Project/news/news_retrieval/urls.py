from django.conf.urls import url

from . import views


urlpatterns = [
    url(r'^index/', views.index),
    url(r'^news_retrieval', views.search)
    url(r'^notfound/', views.notfound, name='notfound'),
]