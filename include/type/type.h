#pragma once

using namespace std;

namespace toylang {

    class Type;

    /**
    * Definition of a type. Independent from context.
    * example: Type<T1:Number, T2:Any>: Super
    */
    class TypeDefinition {       
        public:
            string name;
            bool is_primitive;
            bool is_calleable;

            TypeDefinition* parent;

            vector<pair<string, Type*>> callParameters;
            Type* callReturnType;

            vector<pair<string, Type*>> typeParameters;

            map<string, Type*> properties;

            TypeDefinition(string name) : name { name } {}

            void addProperty(string name, Type* type);
    };

    /**
    * Actual usage of a type.
     example: 
     function <T> genericFnc(T value): Type<Int, T>? {
        return Type(42, value); 
     }
    */
    class Type {
        public:
            TypeDefinition* definition;
            bool nulleable;
            vector<pair<string, Type*>> typeBindings;

            Type* lexicalParent;
    };

    class TypeRepository {
        private:
            static map<string, TypeDefinition*> known_types;

        public:
            static TypeDefinition* getType(string name);
            static void addType(TypeDefinition* type);
    }
}