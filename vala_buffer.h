#ifndef VALA_BUFFER_H
#define VALA_BUFFER_H
#define OBJECT_TO_BUFFER(val,type,size) (*(size) = sizeof(type), (guint8*)val)
#define OBJECT_ARRAY_TO_BUFFER(val,len,type,size) (*(size) = sizeof(type)*(len), (guint8*)val)
#define OBJECT_ARRAY_TO_ARRAY(val,len,typea,typeb,size) (*(size) = sizeof(typea)*(len)/sizeof(typeb), (void*)val)
#define OBJECT_ARRAY_FROM_BUFFER(val,len,type,size) (*(size) = (len)/sizeof(type), (void*)val)
#endif
