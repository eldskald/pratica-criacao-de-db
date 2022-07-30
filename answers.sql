CREATE DATABASE "pratica_criacao_de_db";

CREATE TABLE "customers" (
    "id" SERIAL PRIMARY KEY,
    "fullName" TEXT NOT NULL,
    "cpf" INTEGER NOT NULL UNIQUE,
    "email" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL
);

CREATE TABLE "bankAccounts" (
    "id" SERIAL PRIMARY KEY,
    "customerId" INTEGER NOT NULL REFERENCES "users"("id"),
    "accountNumber" INTEGER NOT NULL UNIQUE,
    "agency" INTEGER NOT NULL,
    "openDate" TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    "closeDate" TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

CREATE TYPE "transactionType" AS ENUM ('deposit', 'withdrawal');

CREATE TABLE "transactions" (
    "id" SERIAL PRIMARY KEY,
    "bankAccountId" INTEGER NOT NULL REFERENCES "bankAccounts"("id"),
    "amount" INTEGER NOT NULL,
    "type" "transactionType" NOT NULL,
    "time" TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    "description" TEXT,
    "cancelled" BOOLEAN NOT NULL
);

CREATE TABLE "creditCards" (
    "id" SERIAL PRIMARY KEY,
    "bankAccountId" INTEGER NOT NULL REFERENCES "bankAccounts"("id"),
    "name" TEXT NOT NULL,
    "number" INTEGER NOT NULL UNIQUE,
    "securityCode" INTEGER NOT NULL,
    "expirationMonth" INTEGER NOT NULL,
    "expirationYear" INTEGER NOT NULL,
    "password" TEXT NOT NULL,
    "limit" INTEGER
);

CREATE TYPE "phoneType" AS ENUM ('landline', 'mobile');

CREATE TABLE "customerPhones" (
    "id" SERIAL PRIMARY KEY,
    "customerId" INTEGER NOT NULL REFERENCES "customers"("id"),
    "number" INTEGER NOT NULL,
    "type" "phoneType" NOT NULL
);

CREATE TABLE "customerAdresses" (
    "id" SERIAL PRIMARY KEY,
    "customerId" INTEGER NOT NULL REFERENCES "customer"("id"),
    "street" TEXT NOT NULL,
    "number" INTEGER NOT NULL,
    "complement" TEXT,
    "postalCode" INTEGER NOT NULL,
    "cityId" INTEGER NOT NULL REFERENCES "cities"("id")
);

CREATE TABLE "cities" (
    "id" SERIAL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "stateId" INTEGER NOT NULL REFERENCES "states"("id")
);

CREATE TABLE "states" (
    "id" SERIAL PRIMARY KEY,
    "name" TEXT NOT NULL
);
