import { ApiProperty } from '@nestjs/swagger';
import {
  IsArray,
  IsEmail,
  IsOptional,
  IsString,
  Matches,
  MaxLength,
  MinLength,
} from 'class-validator';

export class CreateUserDto {
  @ApiProperty({
    description: 'Email del usuario',
    nullable: false,
    example: 'example@example.com',
    format: 'email',
  })
  @IsString()
  @IsEmail()
  email: string;

  @ApiProperty({
    description: 'Contraseña del usuario',
    nullable: false,
    example: 'Password123',
    minLength: 6,
    maxLength: 50,
  })
  @IsString()
  @MinLength(6)
  @MaxLength(50)
  @Matches(/(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$/, {
    message:
      'The password must have a Uppercase, lowercase letter and a number',
  })
  password: string;

  @ApiProperty({
    description: 'Nombre completo del usuario',
    nullable: false,
    example: 'John Mart Doe Doe',
    minLength: 10,
  })
  @IsString()
  @MinLength(1)
  fullName: string;

  @ApiProperty({
    description: 'Roles del usuario',
    nullable: true,
    example: ['teacher', 'student'],
    type: 'array',
    items: { type: 'string' },
  })
  @IsString({ each: true })
  @IsOptional()
  @IsArray()
  roles?: string[];
}
